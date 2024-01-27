import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/partners/ui/filter_bottom_sheet.dart';
import 'package:gear_up/view/userProfile/model/player_profile_response.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/check_box.dart';
import '../../../../utils/utilities.dart';

class EditPlaysBottomSheet extends StatefulWidget {
  final List<FavoriteSport> favouriteSports;
  const EditPlaysBottomSheet({
    super.key,
    required this.favouriteSports,
  });

  @override
  State<EditPlaysBottomSheet> createState() => _EditPlaysBottomSheetState();
}

class _EditPlaysBottomSheetState extends State<EditPlaysBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 16, left: 24, right: 24),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edit Plays',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const Text(
                'Select Your Sports',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                // height: 100,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Sports.values.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        editSportCard(index),
                        const SizedBox(height: 8)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Container editSportCard(int index) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFE2E2E2)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  getSportIconDataFromSportName(Sports.values[index]),
                ),
                const SizedBox(width: 12),
                Text(
                  Strings.sportsList[index],
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      // enabled = !enabled;
                    });
                  },
                  child: isSportPresent(widget.favouriteSports, index)
                      ? const Icon(
                          Icons.do_not_disturb_on_outlined,
                          color: Colors.red,
                          size: 20,
                        )
                      : const Icon(
                          Icons.add_circle_outline_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                ),
              ],
            ),
          ),
          if (isSportPresent(widget.favouriteSports,
              index)) //widget.favouriteSports[0].level.isNotEmpty &&
            //!expandedState && enabled)
            GestureDetector(
              onTap: () {
                setState(() {
                  // expandedState = !expandedState;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 2, left: 36),
                child: Row(
                  children: [
                    Text(
                      widget.favouriteSports[0].level ?? 'abc',
                      style: const TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 12,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next,
                      color: Colors.blue,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
          if (false) //expandedState && enabled)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Divider(height: 1, color: Color(0xFFE2E2E2)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Select your Level',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 6,
                        runSpacing: 6,
                        children: getList(),
                      )
                    ],
                  ),
                )
              ],
            )
        ],
      ),
    );
  }
}

List<Widget> getList() {
  List<Widget> childs = [];
  for (final level in Strings.levelsList) {
    childs.add(SetLevelCheckBox(
      text: level,
    ));
  }
  return childs;
}

bool isSportPresent(List<FavoriteSport> favouriteSports, int index) {
  for (final sport in favouriteSports) {
    if (sport.sport == getSportID(index)) {
      return true;
    }
  }
  return false;
}
