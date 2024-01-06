import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/home/ui/app_bar.dart';
import 'package:gear_up/view/home/ui/partner_level_bottom_sheet.dart';
import 'package:gear_up/view/partners/sports_filter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int userCoins = 100;
  int _index = 0;
  final String userImage =
      'https://i.pinimg.com/originals/77/7e/1b/777e1b0b13cd6b24c420f578e005fb2c.jpg';
  final String userName = 'Hannah';
  final String userAge = '23';
  final String userGender = 'Female';
  final double userDistance = 3.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context, "Brussels"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bucksAndReferWidget(),
            const SizedBox(height: 32),
            partnersNearYouWidget(),
            const SizedBox(height: 12),
            filterWidget(context),
            const SizedBox(height: 24),
            SizedBox(
              height: 360,
              child: Expanded(
                // shrinkWrap: true,
                // height: 360,
                child: PageView.builder(
                  itemCount: 10,
                  // shrinkWrap: true,
                  controller: PageController(viewportFraction: 0.8),
                  onPageChanged: (index) => setState(() => _index = index),
                  itemBuilder: (context, index) {
                    return AnimatedPadding(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.fastOutSlowIn,
                      padding: EdgeInsets.all(_index == index ? 0.0 : 16.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: ClipOval(
                                        child: SizedBox.fromSize(
                                          size: const Size.fromRadius(
                                              60), // Image radius
                                          child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/person_image.png',
                                              image: userImage,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      userName,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'General Sans',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    IntrinsicWidth(
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Text(
                                              '$userAge, $userGender',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Space Grotesk',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            const VerticalDivider(
                                                color: Colors.black),
                                            const SizedBox(width: 8),
                                            Text(
                                              '$userDistance Km away',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontFamily: 'Space Grotesk',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // const SizedBox(height: 14),
                                    // const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Container(
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF1E1E1E),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6.80),
                                  ),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                width: double.infinity,
                                child: const Text(
                                  'Connect',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'General Sans',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 48),
            adWidget(),
          ],
        ),
      ),
    );
  }

  Container adWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 160,
      decoration: ShapeDecoration(
        image: const DecorationImage(
          image: NetworkImage(
              "https://www.aaaa.org/wp-content/uploads/Messi_v4bArjN.png"),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Container filterWidget(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: IntrinsicHeight(
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
                    constraints:
                        const BoxConstraints(minWidth: double.infinity),
                    builder: (BuildContext context) {
                      return const Wrap(children: [PartnerLevelBottomSheet()]);
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
      ),
    );
  }

  Container bucksAndReferWidget() {
    return Container(
      height: 28,
      color: const Color(0xFFF1F54E),
      child: Row(
        children: [
          const SizedBox(width: 24),
          const Icon(
            Icons.star_outlined,
            color: Colors.black,
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            '$userCoins Bucks',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          const Text(
            'Refer & Earn',
            style: TextStyle(
              color: Colors.black,
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.north_east,
            color: Colors.black,
            size: 16,
          ),
          const SizedBox(width: 24)
        ],
      ),
    );
  }

  Container partnersNearYouWidget() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: const Row(
        children: [
          Text(
            'Partners Near You',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.chevron_right,
            size: 32,
          )
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
