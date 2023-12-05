import 'package:flutter/material.dart';

class SetLevelCheckBox extends StatefulWidget {
  final String text;
  const SetLevelCheckBox({super.key, required this.text});

  @override
  State<SetLevelCheckBox> createState() => _SetLevelCheckBox();
}

class _SetLevelCheckBox extends State<SetLevelCheckBox> {
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
              color: _value ? Colors.black : const Color(0xFFE2E2E2),
              style: BorderStyle.solid,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              widget.text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
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
