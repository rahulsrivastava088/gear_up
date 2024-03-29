import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/onBoarding/viewModel/profile_set_up_view_model.dart';
import 'package:provider/provider.dart';

import 'list_item.dart';

class SelectObjectiveListWidget extends StatefulWidget {
  // final int pos;
  const SelectObjectiveListWidget({super.key});

  @override
  State<SelectObjectiveListWidget> createState() =>
      _SelectObjectiveListWidget();
}

class _SelectObjectiveListWidget extends State<SelectObjectiveListWidget> {
  List<ListItem> items = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < Strings.playingObjectiveList.length; i++) {
      items.add(ListItem(index: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileSetUpViewModel>(context);
    return Wrap(
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
              model.selectedObjective = index;
            });
          },
          child: customCheckBoxContainer(index, items[index]),
        ),
      ),
    );
  }
}

Container customCheckBoxContainer(int index, ListItem item) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(80)),
      border: Border.all(
        width: 1,
        color: item.isSelected ? Colors.white : const Color(0xFF333333),
        style: BorderStyle.solid,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        Strings.playingObjectiveList[index],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
