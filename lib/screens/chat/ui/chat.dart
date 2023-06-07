import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/api/apis.dart';
import 'package:vendoo/models/chat_user.dart';
//import 'package:vendoo/screens/messaging/ui/message.dart';
import 'package:vendoo/screens/newroom/ui/newroom.dart';
import 'package:vendoo/screens/account/ui/account.dart';
import '../../../widgets/chat_user_card.dart';
import '../../../models/chat_user.dart';

class ChatRoomJoiningPage extends StatefulWidget {
  ChatRoomJoiningPage({super.key});

  @override
  State<ChatRoomJoiningPage> createState() => _ChatRoomJoiningPageState();
}

class _ChatRoomJoiningPageState extends State<ChatRoomJoiningPage> {
  @override
  initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  //for storing all users
  List<ChatUser> _list = [];
  // for storing searched items
  final List<ChatUser> _searchList = [];
  // for storing search status
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: _isSearching
              ? TextField(
                  autofocus: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                  ),
                  style: TextStyle(fontSize: 16),
                  //when text changes update search list
                  onChanged: (value) {
                    //search logic
                    _searchList.clear();

                    for (var i in _list) {
                      if (i.name.toLowerCase().contains(value.toLowerCase())) {
                        _searchList.add(i);
                        setState(() {
                          _searchList;
                        });
                      }
                    }
                  },
                )
              : const Text('Chat Rooms'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: Icon(_isSearching
                    ? CupertinoIcons.clear_circled_solid
                    : Icons.search)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountPage(
                              user: APIs.me,
                            )),
                  );
                },
                icon: const Icon(Icons.account_circle))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                  stream: APIs.getAllUsers(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return const Center(child: CircularProgressIndicator());
                      case ConnectionState.active:
                      case ConnectionState.done:
                        final data = snapshot.data?.docs;
                        _list = data
                                ?.map((e) => ChatUser.fromJson(e.data()))
                                .toList() ??
                            [];
                        if (_list.isNotEmpty) {
                          return ListView.builder(
                              itemCount: _isSearching
                                  ? _searchList.length
                                  : _list.length,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return chatUserCard(
                                    user: _isSearching
                                        ? _searchList[index]
                                        : _list[index]);
                              });
                        } else {
                          return const Center(
                              child: Text('No connections found!',
                                  style: TextStyle(fontSize: 20)));
                        }
                    }
                  }),
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => const ChatRoomCreationPage()),
        //     );
        //   },
        //   child: const Icon(Icons.add),
        // ),
      ),
    );
  }
}
