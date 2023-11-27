import 'package:flutter/material.dart';

class IntroPageImage extends StatelessWidget {
  const IntroPageImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 150),
          width: 100,
          height: 100,
          decoration: ShapeDecoration(
            color: const Color(0xFF1E1E1E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
        ),
      ],
    );
  }
}
