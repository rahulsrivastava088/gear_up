import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SelectSportsCheckBox extends StatefulWidget {
  final String text;
  const SelectSportsCheckBox({super.key, required this.text});

  @override
  State<SelectSportsCheckBox> createState() => _SelectSportsCheckBox();
}

class _SelectSportsCheckBox extends State<SelectSportsCheckBox> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: Colors.transparent),
      child: CheckboxListTile(
        activeColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        checkColor: Colors.white,
        subtitle: null,
        title: Text(
          widget.text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
        tileColor: const Color(0xFF141414),
        selectedTileColor: const Color(0xFF1E1E1E),
        secondary: SizedBox(
            height: 20,
            width: 20,
            child: SvgPicture.asset(
              'lib/icons/ic_badminton.svg',
            )),
        selected: _value,
        value: _value,
        onChanged: (value) {
          //send clicked item to data manager from here
          setState(() {
            _value = value!;
          });
        },
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    );
  }
}
