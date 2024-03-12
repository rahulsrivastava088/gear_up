import 'package:flutter/material.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/filter/filter_view_model.dart';
import 'package:provider/provider.dart';

import '../../onBoarding/loginUi/commonUI/list_item.dart';

class SelectLevelFilterWidget extends StatefulWidget {
  const SelectLevelFilterWidget({super.key});

  @override
  State<SelectLevelFilterWidget> createState() => _SelectLevelFilterWidget();
}

class _SelectLevelFilterWidget extends State<SelectLevelFilterWidget> {
  List<SelectLevelListItem> items = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < Strings.levelsList.length; i++) {
      items.add(SelectLevelListItem(index: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FilterViewModel>(context);
    return Container(
      width: double.infinity,
      // height: 118,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(color: Color(0xFFF6F6F6)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Opacity(
            opacity: 0.88,
            child: Text(
              'Select your Level',
              style: TextStyle(
                color: Color(0xFF333333),
                fontSize: 14,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: List.generate(
              items.length,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    for (var item in items) {
                      item.isSelected = false;
                    }
                    items[index].isSelected = true;
                    model.favouriteSportLevel = getLevelEnum(index);
                  });
                },
                child: customCheckBoxContainer(index, items[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Container customCheckBoxContainer(int index, SelectLevelListItem item) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(80)),
      border: Border.all(
        width: 1,
        color: item.isSelected ? Colors.black : const Color(0xFFE2E2E2),
        style: BorderStyle.solid,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        Strings.levelsList[index],
        style: const TextStyle(
          color: Color(0xFF333333),
          fontSize: 12,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
