import 'package:flutter/material.dart';

class SendingChatComp extends StatelessWidget {
  final String message;

  SendingChatComp({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: const BoxConstraints(
              maxWidth: 286,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: ShapeDecoration(
              color: const Color(0xFF4E09A5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
                height: 1.4,
                letterSpacing: 0.21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
