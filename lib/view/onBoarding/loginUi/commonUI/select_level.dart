import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';

import '../../../../utils/utilities.dart';
import '../../../partners/ui/filter_bottom_sheet.dart';
import 'select_level_check_box_list_widget.dart';

class SelectLevelWidget extends StatefulWidget {
  final int index;
  final ProfileSetUpViewModel model;
  final int pos;
  const SelectLevelWidget(
      {super.key, required this.index, required this.model, required this.pos});

  @override
  State<SelectLevelWidget> createState() => _SelectLevelWidgetState();
}

class _SelectLevelWidgetState extends State<SelectLevelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: cardBgColor,
          ),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  getSportIconDataFromSportName(Sports.values[widget.index]),
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                Strings.sportsList[widget.index],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: Color(0xFF1E1E1E),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                Strings.selectYourLevel,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              SelectLevelListWidget(pos: widget.pos),
            ],
          ),
        )
      ],
    );
  }
}
