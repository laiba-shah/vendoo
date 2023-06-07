import 'package:flutter/material.dart';
import 'package:vendoo/api/apis.dart';
import 'package:vendoo/helper/my_date_util.dart';

import '../models/message.dart';

class MessageCard extends StatefulWidget {
  final Message message;
  const MessageCard({super.key, required this.message});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    return APIs.user.uid == widget.message.fromId
        ? _greenMessage()
        : _blueMessage();
  }

  //sender message
  Widget _blueMessage() {


    //update last read message if sender and reciever are different
    if(widget.message.read.isEmpty){
      APIs.updateMessageReadStatus(widget.message);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 144, 189, 226),
                border: Border.all(color: Colors.blueAccent),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              widget.message.message,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Text(
            MyDateUtil.getformattedTime(
                context: context, time: widget.message.sent),
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        )
      ],
    );
  }

  //user message
  Widget _greenMessage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),

            //double tick blue icon for message read
            if (widget.message.read.isNotEmpty)
              const Icon(
                Icons.done_all_rounded,
                color: Colors.blueAccent,
                size: 20,
              ),
            const SizedBox(
              width: 3,
            ),

            //sent time
            Text(
              MyDateUtil.getformattedTime(
                  context: context, time: widget.message.sent),
              style: const TextStyle(fontSize: 13, color: Colors.black54),
            ),
          ],
        ),
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 184, 94, 215),
                border:
                    Border.all(color: const Color.fromARGB(255, 110, 105, 213)),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              widget.message.message,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ),
      ],
    );
  }
}
