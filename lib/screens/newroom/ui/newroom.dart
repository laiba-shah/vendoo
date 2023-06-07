import 'package:flutter/material.dart';
import 'package:vendoo/screens/chat/ui/chat.dart';
import '../../../widgets/chatbutton.dart';

class ChatRoomCreationPage extends StatefulWidget {
  const ChatRoomCreationPage({Key? key}) : super(key: key);

  @override
  _ChatRoomCreationPageState createState() => _ChatRoomCreationPageState();
}

class _ChatRoomCreationPageState extends State<ChatRoomCreationPage> {
  String? chatRoomName;
  String? chatRoomDescription;

  Future<void> _selectImageFromDevice() async {
    // Implement image selection logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Chat Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: () {
                  _selectImageFromDevice();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(Icons.upload_file,
                      size: 50, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            const Text('Set the name of the chat room:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  chatRoomName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text('Set the description of the chat room:'),
            TextField(
              onChanged: (value) {
                setState(() {
                  chatRoomDescription = value;
                });
              },
            ),
            const SizedBox(height: 32.0),
            SizedBox(
              height: 50,
              width: 200,
              child: ChatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatRoomJoiningPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
