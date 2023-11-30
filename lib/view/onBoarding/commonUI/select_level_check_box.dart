import 'package:flutter/material.dart';

class CustomCheckBox extends StatefulWidget {
  final String text;
  const CustomCheckBox({super.key, required this.text});

  @override
  State<CustomCheckBox> createState() => _CustomCheckBox();
}

class _CustomCheckBox extends State<CustomCheckBox> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.transparent),
      child: InkWell(
        onTap: () {
          // set level here
          setState(() {
            _value = !_value;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(80)),
            border: Border.all(
              width: 1,
              color: _value ? Colors.white : const Color(0xFF333333),
              style: BorderStyle.solid,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
