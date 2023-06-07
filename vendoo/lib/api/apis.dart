import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/models/chat_user.dart';
import 'package:vendoo/models/message.dart';
import 'dart:io'; // Import the dart:io library for File class

class APIs {
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  //get instance of the current user
  static User get user => auth.currentUser!;

  //creating a user instance for myself
  static late ChatUser me;

// checking to see if a user already exists
  static Future<bool> userExists() async {
    if (user != null) {
      final userSnapshot =
          await firestore.collection('Users').doc(user.uid).get();
      return userSnapshot.exists;
    }
    return false;
  }

  // for accessing firebase storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //send chat image
  static Future<void> sendChatImage(ChatUser chatUser, File file) async {
    //getting image file extension
    final ext = file.path.split('.').last;

    //storage file ref with path
    final ref = storage.ref().child(
        'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    //uploading image
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {
      log('Data Transferred: ${p0.bytesTransferred / 1000} kb');
    });

    //updating image in firestore database
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, Type.image);
  }

  //getting the user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('Users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  //creating a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();
    print("user object created");
    final chatUser = ChatUser(
        id: user.uid,
        name: 'new user', //user.displayName.toString(),
        email: user.email.toString(),
        about: "Hey I am using vendoo",
        image: user.photoURL.toString(),
        createdAt: time,
        isOnline: false,
        lastActive: time,
        pushToken: '');

    //adding the user to the firestore collection
    return await firestore
        .collection('Users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // for getting all users from firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('Users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  //updating user info
  static Future<void> updateUserInfo() async {
    await firestore
        .collection('Users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('Chats/${getConversationID(user.id)}/Messages/')
        .snapshots();
  }

  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';

  //chats (collection) --> conversation_id (doc) -->  messages(collection) --> message (doc)

  //for sending message
  static Future<void> sendMessage(
      ChatUser Chatuser, String msg, Type image) async {
    final time = DateTime.now()
        .millisecondsSinceEpoch
        .toString(); // will generate a unique string every time
    //message to send
    final Message message = Message(
        read: '',
        message: msg,
        toId: Chatuser.id,
        type: Type.Text,
        sent: time,
        fromId: user.uid);

    final ref = firestore
        .collection('Chats/${getConversationID(Chatuser.id)}/Messages/');
    await ref.doc(time).set(message.toJson());
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUser user) {
    return firestore
        .collection('Chats/${getConversationID(user.id)}/Messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  //updating the user read message status
  static Future<void> updateMessageReadStatus(Message message) async {
    firestore
        .collection('Chats/${getConversationID(message.fromId)}/Messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
}
