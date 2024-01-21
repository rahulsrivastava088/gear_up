import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/view/myGames/gameCard/mainUi/app_bar.dart';
import 'package:gear_up/view/myGames/gameCard/mainUi/game_card.dart';
import 'package:gear_up/view/myGames/gameCard/viewmodel/game_card_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/response/status.dart';

class MyGamesScreen extends StatelessWidget {
  const MyGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GameCardViewModel>(context);
    if (!model.apiCalled) {
      model.fetchMyGames(context);
      return shimmerUI(context);
    } else if (model.gamesListResponse.status == Status.LOADING) {
      return shimmerUI(context);
    } else if (model.gamesListResponse.status == Status.ERROR) {
      return errorUI(context);
    } else {
      return ui(context, model);
    }
  }

  Scaffold shimmerUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox(
          width: double.infinity,
          height: 20,
        ),
      ),
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: const Text(
            'Shimmering Text',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Scaffold errorUI(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
            "Couldn't fetch data due to some server error, please retry after some time."),
      ),
      // Add a retry button here, UI to be made
    );
  }

  Scaffold ui(BuildContext context, GameCardViewModel model) {
    return Scaffold(
      appBar: myGamesAppBar(context),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: myGamesTabBar(),
          body: TabBarView(
            children: [
              liveGamesTab(model),
              upcomingGamesTab(model),
              recentGamesTab(model),
            ],
          ),
        ),
      ),
    );
  }

  AppBar myGamesTabBar() {
    return AppBar(
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
    );
  }

  Padding recentGamesTab(GameCardViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: model.recentGames().isNotEmpty
          ? recentGamesListWidget(model)
          : emptyListTextWidget('No Recent Games'),
    );
  }

  ListView recentGamesListWidget(GameCardViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.recentGames().length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GameCard(game: model.recentGames()[index]);
      },
    );
  }

  Padding upcomingGamesTab(GameCardViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: model.upcomingGames().isNotEmpty
          ? upcomingGamesListWidget(model)
          : emptyListTextWidget('No Upcoming Games'),
    );
  }

  ListView upcomingGamesListWidget(GameCardViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.upcomingGames().length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GameCard(game: model.upcomingGames()[index]);
      },
    );
  }

  Padding liveGamesTab(GameCardViewModel model) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: model.liveGames().isNotEmpty
          ? liveGamesListWidget(model)
          : emptyListTextWidget('No Live Games'),
    );
  }

  Center emptyListTextWidget(String text) {
    return Center(
      child: emptyListText(text),
    );
  }

  Text emptyListText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 16,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  ListView liveGamesListWidget(GameCardViewModel model) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: model.liveGames().length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return GameCard(game: model.liveGames()[index]);
      },
    );
  }
}
