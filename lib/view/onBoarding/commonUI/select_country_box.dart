import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 342,
          height: 44,
          padding: const EdgeInsets.only(
            top: 8,
            left: 12,
            right: 12,
            bottom: 12,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            border: Border(
              left: BorderSide(color: Color(0xFF333333)),
              top: BorderSide(color: Color(0xFF333333)),
              right: BorderSide(color: Color(0xFF333333)),
              bottom: BorderSide(width: 1, color: Color(0xFF333333)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'India',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                  height: 0.07,
                  letterSpacing: 0.09,
                ),
              ),
              const SizedBox(width: 6),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 24,
                      height: 24,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: const Stack(children: []),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
