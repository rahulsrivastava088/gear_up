import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/data/response/status.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/filter/filter_view_model.dart';
import 'package:gear_up/view/home/ui/app_bar.dart';
import 'package:gear_up/view/home/ui/select_sports_widget.dart';
import 'package:gear_up/view/home/viewModel/home_page_view_model.dart';
import 'package:gear_up/view/partners/ui/sports_filter.dart';
import 'package:provider/provider.dart';
import '../../bottomNavigation/custom.dart';
import '../../partners/ui/filter_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int userCoins = 100;
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PlayersViewModel>(context);
    final filterViewModel = Provider.of<FilterViewModel>(context);
    if (model.playersListResponse.status == Status.IDLE) {
      model.fetchPlayers(context, filterViewModel.getPlayersListRequestBody());
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (model.playersListResponse.status == Status.LOADING) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (model.playersListResponse.status == Status.ERROR) {
      return errorUI(model);
    } else if (model.playersListResponse.status == Status.COMPLETED) {
      return ui(context, model, filterViewModel);
    } else {
      return errorUI(model);
    }
  }

  Scaffold errorUI(PlayersViewModel model) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Couldn't fetch players due to some issue, kindly retry",
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                model.playersListResponse = ApiResponse.idle();
                model.notifyListeners();
              },
              child: const Icon(
                Icons.refresh,
                size: 32,
                color: Color(0xFFAFAFAF),
              ),
            )
          ],
        ),
      ),
    );
  }

  Scaffold ui(BuildContext context, PlayersViewModel model,
      FilterViewModel filterViewModel) {
    return Scaffold(
      appBar: homeAppBar(context, "Brussels"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bucksAndReferWidget(),
            const SizedBox(height: 32),
            partnersNearYouWidget(),
            const SizedBox(height: 12),
            filterWidget(context, model, filterViewModel),
            const SizedBox(height: 24),
            SizedBox(
              height: 410,
              child: PageView.builder(
                itemCount: model.playersLengthCount() != null
                    ? model.playersLengthCount() + 1
                    : 1,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) {
                  if (model.playersLengthCount() == 0) {
                    return noPlayerCard(index);
                  } else if (index == model.playersLengthCount()) {
                    return viewAllCard(index);
                  } else {
                    return playersCard(model, index);
                  }
                },
              ),
            ),
            const SizedBox(height: 48),
            adWidget(),
          ],
        ),
      ),
    );
  }

  GestureDetector playersCard(PlayersViewModel model, int index) {
    return GestureDetector(
      onTap: () {
        CustomNavigationHelper.router.push(
            CustomNavigationHelper.playerProfilePath,
            extra: model.playersListResponse.data?.players?[index].id);
      },
      child: AnimatedPadding(
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
                            size: const Size.fromRadius(60), // Image radius
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assets/images/person_image.png',
                              image: model.playersListResponse.data
                                      ?.players?[index].img ??
                                  '',
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  "assets/images/person_image.png",
                                  width: 100,
                                  height: 100,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        model.playersListResponse.data?.players?[index].name ??
                            "-",
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
                                '${model.playersListResponse.data?.players?[index].age ?? "-"}, ${model.playersListResponse.data?.players?[index].gender ?? "-"}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'Space Grotesk',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const VerticalDivider(color: Colors.black),
                              const SizedBox(width: 8),
                              Text(
                                '${model.playersListResponse.data?.players?[index].distance ?? "-"} Km away',
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
                      const SizedBox(height: 14),
                      SizedBox(
                        height: 32,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: model.playersListResponse.data
                                  ?.players?[index].favoriteSports?.length ??
                              0,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xFFE2E2E2))),
                              child: SvgPicture.asset(
                                getSportIconData(model.playersListResponse.data
                                    ?.players?[index].favoriteSports?[i].sport),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    model.sendConnectionRequest(
                        model.playersListResponse.data?.players?[index].id);
                  },
                  child: Container(
                    decoration: ShapeDecoration(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.80),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    child: Text(
                      getButtonText(model, index),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getButtonText(PlayersViewModel model, int index) {
    if (!model.userConnectionStatus
        .containsKey(model.playersListResponse.data?.players?[index].id)) {
      return 'Connect';
    } else {
      switch (model.userConnectionStatus[
          model.playersListResponse.data?.players?[index].id]) {
        case 0:
          return 'Sending Request';
        case 1:
          return 'Request Sent';
        case 2:
          return 'Connect';
      }
    }
  }

  GestureDetector viewAllCard(int index) {
    return GestureDetector(
      onTap: () {
        CustomNavigationHelper.router.go(
          CustomNavigationHelper.partnersPath,
        );
      },
      child: AnimatedPadding(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
        padding: EdgeInsets.all(_index == index ? 0.0 : 16.0),
        child: const Card(
          color: Colors.white,
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Spacer(),
                Icon(
                  Icons.arrow_forward,
                  size: 32,
                  color: Colors.black,
                ),
                SizedBox(height: 48),
                Text(
                  'View all',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AnimatedPadding noPlayerCard(int index) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      padding: EdgeInsets.all(_index == index ? 0.0 : 16.0),
      child: const Card(
        color: Colors.white,
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Spacer(flex: 6),
              Text(
                'No results',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(flex: 5),
              Text(
                'Explore additional players\nby adjusting the filter',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Spacer(flex: 3)
            ],
          ),
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
          image: NetworkImage(''),
          // "https://www.aaaa.org/wp-content/uploads/Messi_v4bArjN.png"),
          fit: BoxFit.fill,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Container filterWidget(BuildContext context, PlayersViewModel model,
      FilterViewModel filterViewModel) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 32,
                child: HomeSelectSportsWidget(
                    lastSelectedIndex:
                        filterViewModel.currentlySelectedSportIndex),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: Color(0xFF333333),
            ),
            const SizedBox(width: 8),
            filterTapIcon(context, model, filterViewModel),
          ],
        ),
      ),
    );
  }

  GestureDetector filterTapIcon(BuildContext context, PlayersViewModel model,
      FilterViewModel filterViewModel) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          constraints: const BoxConstraints(minWidth: double.infinity),
          builder: (BuildContext context) {
            return Wrap(children: [
              FilterBottomSheet(
                onTap: () {
                  setState(() {
                    model.playersListResponse = ApiResponse.idle();
                  });
                },
                selectedDistance: filterViewModel.range.toDouble(),
                selectedStartAge: filterViewModel.minAge.toDouble(),
                selectedEndAge: filterViewModel.maxAge.toDouble(),
                selectedGender: filterViewModel.gender,
                selectedSports: filterViewModel.favouriteSport,
                selectedLevel: filterViewModel.favouriteSportLevel,
              )
            ]);
          },
        );
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
