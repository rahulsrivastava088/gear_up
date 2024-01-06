import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/partners/app_bar.dart';
import 'package:gear_up/view/partners/filter_bottom_sheet.dart';
import 'package:gear_up/view/partners/sports_filter.dart';

class PartnersScreen extends StatelessWidget {
  final String userImage =
      'https://i.insider.com/64395d57f62706001943009e?width=1200&format=jpeg';
  final String userName = 'Muggle';
  final String userAge = '23';
  final String userGender = 'Female';
  final String userDistance = '2.5 Km away';
  final String userRating = '4.8';

  const PartnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: partnersAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Column(
          children: [
            filterWidget(context),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Center(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(24), // Image radius
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/person_image.png',
                          image: userImage,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              '$userAge, $userGender • $userDistance',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '$userRating ★',
                              style: const TextStyle(
                                color: Color(0xFFAFAFAF),
                                fontSize: 12,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Center(
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(24), // Image radius
                      child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/person_image.png',
                          image: userImage,
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1, color: Color(0xFF333333)),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              '$userAge, $userGender • $userDistance',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '$userRating ★',
                              style: const TextStyle(
                                color: Color(0xFFAFAFAF),
                                fontSize: 12,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  IntrinsicHeight filterWidget(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 32,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: getList(),
              ),
            ),
          ),
          const VerticalDivider(
            width: 1,
            color: Color(0xFF333333),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  builder: (BuildContext context) {
                    return const Wrap(children: [FilterBottomSheet()]);
                  });
            },
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF333333)),
                  borderRadius: BorderRadius.circular(80),
                ),
              ),
              child: const Icon(
                Icons.filter_alt_outlined,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getList() {
  List<Widget> childs = [];
  for (final level in Strings.sportsList) {
    childs.add(SportsFilter(text: level));
    childs.add(const SizedBox(width: 8));
  }
  return childs;
}
