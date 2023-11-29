import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF1E1E1E),
    ),
  );
}
