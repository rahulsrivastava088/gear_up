import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/home/app_bar.dart';
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
      body: Column(
        children: [
          Container(
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
          ),
          SizedBox(
            height: 360,
            child: PageView.builder(
              itemCount: 10,
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
                          Container(
                            decoration: ShapeDecoration(
                              color: const Color(0xFF1E1E1E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.80),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
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
