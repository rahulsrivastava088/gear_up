import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/view/myGames/app_bar.dart';
import 'package:gear_up/view/myGames/live_card.dart';
import 'package:gear_up/view/myGames/recent_card.dart';
import 'package:gear_up/view/myGames/upcoming_card.dart';

class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myGamesAppBar(context),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            backgroundColor: cardBgColor,
            title: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 1, color: Colors.white),
              ),
              tabs: [
                Tab(text: 'Live'),
                Tab(text: 'Upcoming'),
                Tab(text: 'Recent'),
              ],
              labelStyle: TextStyle(
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelColor: Color(0xFFAFAFAF),
              labelColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const LiveGameCard(
                        opponentName: 'God', sportsName: 'Life');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const UpComingGameCard(
                        opponentName: 'God',
                        sportsName: 'Life',
                        matchDate: '36 Feb, 2099');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return const RecentGameCard(
                      opponentName: 'God',
                      sportsName: 'Life',
                      matchDate: '36 Feb, 2099',
                      result: 'Won',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
