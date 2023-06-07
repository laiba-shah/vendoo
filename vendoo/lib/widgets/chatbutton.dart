import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ChatButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.0),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          padding:
              MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
          minimumSize: MaterialStateProperty.all<Size>(const Size(0, 0)),
          elevation: MaterialStateProperty.all<double>(0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: MaterialStateProperty.all<TextStyle>(
            const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 17,
              height: 1.24,
            ),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF53EAEB),
                Color(0xFF016BB4),
                Color(0xFF2D3A93),
                Color(0xFF8139B8),
                Color(0xFF783BB3),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0712, 0.285, 0.4562, 0.7251, 0.9251],
            ),
            borderRadius: BorderRadius.circular(28.0),
          ),
          child: Container(
            alignment: Alignment.center,
            child: const Text(
              'Chat',
              style: TextStyle(fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
