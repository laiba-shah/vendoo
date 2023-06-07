import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vendoo/api/apis.dart';
import 'package:vendoo/helper/my_date_util.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/messageScreen/ui/messageScreen.dart';

class chatUserCard extends StatefulWidget {
  final ChatUser user;

  const chatUserCard({super.key, required this.user});

  @override
  State<chatUserCard> createState() => _chatUserCardState();
}

class _chatUserCardState extends State<chatUserCard> {
  //last message , if null --> no message
  Message? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0.5,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MessageScreen(
                            user: widget.user,
                          )));
            },
            child: StreamBuilder(
              stream: APIs.getLastMessage(widget.user),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => Message.fromJson(e.data())).toList() ?? [];
                if (list.isNotEmpty) {
                  _message = list[0];
                }
                return ListTile(
                  leading: CachedNetworkImage(
                      imageUrl: widget.user.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                          child: Icon(CupertinoIcons.person))),
                  //CircleAvatar(child: Icon(CupertinoIcons.person)),
                  title: Text(widget.user.name),
                  subtitle: Text(
                      _message != null ? _message!.message : widget.user.about,
                      maxLines: 1),

                  trailing: _message == null
                      ? null
                      : _message!.read.isEmpty &&
                              _message!.fromId != APIs.user.uid
                          ? Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                color: Colors.purpleAccent.shade100,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )
                          : Text(
                              MyDateUtil().getLastMessageTime(
                                  context: context, time: _message!.sent),
                              style: TextStyle(color: Colors.black54),
                            ),
                );
              },
            )));
  }
}
