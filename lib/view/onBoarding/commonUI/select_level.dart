import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/Strings.dart';
import 'package:gear_up/view/onBoarding/commonUI/select_level_check_box.dart';

class SelectLevelWidget extends StatefulWidget {
  final String sportName;
  const SelectLevelWidget({super.key, required this.sportName});

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
              const Icon(Icons.circle_outlined),
              const SizedBox(width: 12),
              Text(
                widget.sportName,
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
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 6,
                runSpacing: 6,
                children: getList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

List<Widget> getList() {
  List<Widget> childs = [];
  for (final level in Strings.levelsList) {
    childs.add(CustomCheckBox(text: level));
  }
  return childs;
}
