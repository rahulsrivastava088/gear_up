import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), // Adjust the radius as needed
          topRight: Radius.circular(20),
        ),
      ),
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1E1E1E),
    ),
  );
}
