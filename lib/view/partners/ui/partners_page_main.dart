import 'package:flutter/material.dart';
import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/home/viewModel/home_page_view_model.dart';
import 'package:gear_up/view/partners/ui/app_bar.dart';
import 'package:gear_up/view/partners/ui/filter_bottom_sheet.dart';
import 'package:gear_up/view/partners/ui/sports_filter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/response/status.dart';
import '../../bottomNavigation/custom.dart';
import '../../filter/filter_view_model.dart';
import '../../home/ui/select_sports_widget.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  final String userRating = '4.8';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PlayersViewModel>(context);
    final filterViewModel = Provider.of<FilterViewModel>(context);
    if (model.playersListResponse.status == Status.IDLE) {
      model.fetchPlayers(context, filterViewModel.getPlayersListRequestBody());
      return _shimmerUi(context);
    } else if (model.playersListResponse.status == Status.LOADING) {
      return _shimmerUi(context);
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

  Scaffold _shimmerUi(BuildContext context) {
    return Scaffold(
      appBar: partnersAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[700]!,
          child: Column(
            children: [
              filterShimmer(),
              const SizedBox(height: 30),
              Expanded(child: ListView.builder(itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // Set the desired background color
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(width: 1, color: Color(0xFF333333)),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 100,
                              height: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 30,
                                  height: 12,
                                  color: Colors.white,
                                ),
                                const Spacer(),
                                Container(
                                  width: 20,
                                  height: 12,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }))
            ],
          ),
        ),
      ),
    );
  }

  filterShimmer() => IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 32,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: getShimmerList(),
                ),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: Color(0xFF333333),
            ),
            const SizedBox(width: 8),
            Container(
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
          ],
        ),
      );

  Scaffold ui(BuildContext context, PlayersViewModel model,
      FilterViewModel filterViewModel) {
    return Scaffold(
      appBar: partnersAppBar(context),
      body: playersListWidget(context, model, filterViewModel),
    );
  }

  Padding playersListWidget(BuildContext context, PlayersViewModel model,
      FilterViewModel filterViewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      child: Column(children: [
        filterWidget(context, model, filterViewModel),
        const SizedBox(height: 24),
        playersListListView(model),
      ]),
    );
  }

  Widget playersListListView(PlayersViewModel model) {
    if (model.playersLengthCount() == 0) {
      return _emptyStateUi();
    } else {
      return Expanded(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: model.playersLengthCount() ?? 0,
          itemBuilder: (context, index) {
            return _playerCard(model, index);
          },
        ),
      );
    }
  }

  Widget _emptyStateUi() {
    return const Expanded(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Text(
              'No results',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Explore additional players\nby adjusting the filter',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 16,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(flex: 3)
          ],
        ),
      ),
    );
  }

  GestureDetector _playerCard(PlayersViewModel model, int index) {
    return GestureDetector(
      onTap: () {
        CustomNavigationHelper.router.push(
            CustomNavigationHelper.playerProfilePath,
            extra: model.playersListResponse.data?.players?[index].id);
      },
      child: Row(
        children: [
          Center(
            child: ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(24), // Image radius
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/person_image.png',
                  image:
                      model.playersListResponse.data?.players?[index].img ?? '',
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
                    model.playersListResponse.data?.players?[index].name ?? "-",
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
                        '${model.playersListResponse.data?.players?[index].age ?? "-"}, ${model.playersListResponse.data?.players?[index].gender ?? "-"} • ${model.playersListResponse.data?.players?[index].distance ?? '-' 'km away'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${model.playersListResponse.data?.players?[index].rating ?? "-"} ★',
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
    );
  }

  IntrinsicHeight filterWidget(BuildContext context, PlayersViewModel model,
      FilterViewModel filterViewModel) {
    return IntrinsicHeight(
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
          GestureDetector(
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

List<Widget> getShimmerList() {
  List<Widget> childs = [];
  for (final _ in Strings.sportsList) {
    childs.add(
      Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(80)),
          border: Border.all(
            width: 1,
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
    childs.add(const SizedBox(width: 8));
  }
  return childs;
}
