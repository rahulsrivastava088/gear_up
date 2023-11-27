import 'package:flutter/material.dart';

class LoginCheckBox extends StatefulWidget {
  const LoginCheckBox({super.key});

  @override
  State<LoginCheckBox> createState() => _LoginCheckBox();
}

class _LoginCheckBox extends State<LoginCheckBox> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      checkColor: Colors.black,
      activeColor: Colors.white,
      onChanged: (value) {
        setState(() {
          this.value = value!;
        });
      },
    );
  }
}
