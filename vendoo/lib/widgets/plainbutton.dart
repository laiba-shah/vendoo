import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LoginSignupButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0xFFD9D9D9)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: const BorderSide(color: Colors.grey), // Add border color
            ),
          ),
          elevation: MaterialStateProperty.all<double>(8), // Adjust elevation
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.grey[800]),
        ),
      ),
    );
  }
}
