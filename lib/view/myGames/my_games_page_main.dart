import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/view/myGames/gameCard/mainUi/app_bar.dart';
import 'package:gear_up/view/myGames/gameCard/mainUi/game_card.dart';
import 'package:gear_up/view/myGames/gameCard/viewmodel/game_card_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../data/response/status.dart';

class MyGamesScreen extends StatefulWidget {
  // final bool refresh;
  const MyGamesScreen({
    super.key,
  });

  @override
  State<MyGamesScreen> createState() {
    print("create state called");
    return _MyGamesScreenState();
  }
}

class _MyGamesScreenState extends State<MyGamesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("my games init state");
    // _refresh = widget.refresh;
  }

  // bool _refresh = false;

  @override
  Widget build(BuildContext context) {
    print("build called");
    final model = Provider.of<GameCardViewModel>(context);
    if (!model.apiCalled) {
      // refresh = false;
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
            'Loading the Games',
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
          initialIndex: model.tabIndex,
          length: 3,
          child: Builder(builder: (BuildContext context) {
            return Scaffold(
              appBar: myGamesTabBar(),
              body: TabBarView(
                children: [
                  liveGamesTab(context, model),
                  upcomingGamesTab(context, model),
                  recentGamesTab(context, model),
                ],
              ),
            );
          }),
        ));
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

  Padding recentGamesTab(BuildContext context, GameCardViewModel model) {
    // model.tabIndex = 2;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: model.recentGames().isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                _refresh(context, model);
              },
              child: recentGamesListWidget(model))
          : RefreshIndicator(
              onRefresh: () async {
                _refresh(context, model);
              },
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(
                    child: emptyListTextWidget('No Recent Games'))
              ]),
            ),
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

  Padding upcomingGamesTab(BuildContext context, GameCardViewModel model) {
    // model.tabIndex = 1;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: model.upcomingGames().isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                _refresh(context, model);
              },
              child: upcomingGamesListWidget(model))
          : RefreshIndicator(
              onRefresh: () async {
                _refresh(context, model);
              },
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(
                    child: emptyListTextWidget('No Upcoming Games'))
              ])),
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

  void _refresh(BuildContext context, GameCardViewModel model) {
    model.tabIndex = DefaultTabController.of(context).index;
    model.apiCalled = false;
    model.notifyListeners();
  }

  int getCurrentTabIndex(BuildContext context) {
    return DefaultTabController.of(context).index;
  }

  Widget liveGamesTab(BuildContext context, GameCardViewModel model) {
    // model.tabIndex = 0;
    return Padding(
      padding: const EdgeInsets.all(24),
      child: model.liveGames().isNotEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                _refresh(context, model);
              },
              child: liveGamesListWidget(model))
          : RefreshIndicator(
              onRefresh: () async {
                _refresh(context, model);
              },
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(child: emptyListTextWidget('No Live Games'))
              ])),
    );
  }

  Widget emptyListTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 240),
      child: Center(
        child: emptyListText(text),
      ),
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
