import 'package:flutter/material.dart';

class CustomBigButtonLight extends StatelessWidget {
  final String text;
  final Function onTap;
  const CustomBigButtonLight(
      {super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48,
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                onTap();
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomBigButtonDark extends StatelessWidget {
  final String text;
  final Function onTap;
  const CustomBigButtonDark(
      {super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48,
          decoration: ShapeDecoration(
            color: const Color(0xFF1E1E1E),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                onTap();
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomBigButtonGrey extends StatelessWidget {
  final String text;
  final Function onTap;
  const CustomBigButtonGrey(
      {super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 48,
          decoration: ShapeDecoration(
            color: const Color(0xFFF6F6F6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () {
                onTap();
              },
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
