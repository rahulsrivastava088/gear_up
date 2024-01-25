import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/filter/filter_view_model.dart';
import 'package:gear_up/view/home/ui/partner_level_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../onBoarding/loginUi/commonUI/list_item.dart';

class HomeSelectSportsWidget extends StatefulWidget {
  // final int pos;
  const HomeSelectSportsWidget({super.key});

  @override
  _ListViewState createState() => _ListViewState();
}

class _ListViewState extends State<HomeSelectSportsWidget> {
  List<ListItem> items = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < Strings.sportsList.length; i++) {
      items.add(ListItem(index: i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: List.generate(
        items.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              for (var item in items) {
                item.isSelected = false;
              }
              items[index].isSelected = true;
              showModalBottomSheet(
                useRootNavigator: true,
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                constraints: const BoxConstraints(minWidth: double.infinity),
                builder: (BuildContext context) {
                  return Wrap(
                    children: [
                      PartnerLevelBottomSheet(selectedSportIndex: index)
                    ],
                  );
                },
              );
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
    margin: const EdgeInsets.only(right: 6),
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
        Strings.sportsList[index],
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}
