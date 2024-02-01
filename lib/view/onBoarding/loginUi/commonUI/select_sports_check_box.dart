import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:gear_up/view/partners/ui/filter_bottom_sheet.dart';

import '../../../../utils/utilities.dart';

class SelectSportsCheckBox extends StatefulWidget {
  final int index;
  final ProfileSetUpViewModel model;

  const SelectSportsCheckBox(
      {super.key, required this.index, required this.model});

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
          Strings.sportsList[widget.index],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
        tileColor: cardBgColor,
        selectedTileColor: const Color(0xFF1E1E1E),
        secondary: SizedBox(
          height: 20,
          width: 20,
          child: SvgPicture.asset(
            getSportIconDataFromSportName(Sports.values[widget.index]),
            color: Colors.white,
          ),
        ),
        selected: _value,
        value: _value,
        onChanged: (value) {
          //send clicked item to data manager from here
          setState(() {
            _value == true
                ? widget.model.markSportAsUnselected(widget.index)
                : widget.model.markSportAsSelected(widget.index);
            _value = value!;
          });
        },
        side: const BorderSide(width: 0, color: Colors.transparent),
      ),
    );
  }
}
