import 'package:flutter/material.dart';
import 'package:gear_up/data/response/status.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/home/ui/app_bar.dart';
import 'package:gear_up/view/home/ui/partner_level_bottom_sheet.dart';
import 'package:gear_up/view/home/ui/select_sports_widget.dart';
import 'package:gear_up/view/home/viewModel/home_page_view_model.dart';
import 'package:gear_up/view/partners/ui/sports_filter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../project/routes/app_route_constants.dart';
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
    final model = Provider.of<HomePageViewModel>(context);
    if (!model.apiCalled) {
      model.fetchAllPlayers(context);
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (model.playersListResponse.status == Status.LOADING) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ui(context, model);
    }
  }

  Scaffold ui(BuildContext context, HomePageViewModel model) {
    return Scaffold(
      appBar: homeAppBar(context, "Brussels"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            bucksAndReferWidget(),
            const SizedBox(height: 32),
            partnersNearYouWidget(),
            const SizedBox(height: 12),
            filterWidget(context, model),
            const SizedBox(height: 24),
            SizedBox(
              height: 360,
              child: PageView.builder(
                itemCount: model.playersLengthCount() != null
                    ? model.playersLengthCount() + 1
                    : 1,
                // shrinkWrap: true,
                controller: PageController(viewportFraction: 0.8),
                onPageChanged: (index) => setState(() => _index = index),
                itemBuilder: (context, index) {
                  // if(){}
                  if (index == model.playersLengthCount()) {
                    return GestureDetector(
                      onTap: () {
                        // context.go('/home_page', extra: 1);
                        // GoRouter.of(context).pushNamed(
                        //   RouteConstants.homePageRouteName,
                        //   extra: 1,
                        // );

                        CustomNavigationHelper.router.go(
                          CustomNavigationHelper.partnersPath,
                        );
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
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward,
                                  size: 32,
                                  color: Colors.black,
                                ),
                                const SizedBox(height: 32),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 12),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF6F6F6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                  ),
                                  child: const Text(
                                    'View all',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'General Sans',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Spacer()
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        CustomNavigationHelper.router.push(
                            CustomNavigationHelper.playerProfilePath,
                            extra: model.playersListResponse.data
                                ?.playersWithConnections?[index].id);
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: ClipOval(
                                          child: SizedBox.fromSize(
                                            size: const Size.fromRadius(
                                                60), // Image radius
                                            child: FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/person_image.png',
                                              image: model
                                                      .playersListResponse
                                                      .data
                                                      ?.playersWithConnections?[
                                                          index]
                                                      .img ??
                                                  '',
                                              fit: BoxFit.cover,
                                              imageErrorBuilder:
                                                  (context, error, stackTrace) {
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
                                        model
                                                .playersListResponse
                                                .data
                                                ?.playersWithConnections?[index]
                                                .firstName ??
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
                                                '${model.playersListResponse.data?.playersWithConnections?[index].age ?? "-"}, ${model.playersListResponse.data?.playersWithConnections?[index].gender ?? "-"}',
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
                                                '${model.playersListResponse.data?.playersWithConnections?[index].distance ?? "-"} Km away',
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
                      ),
                    );
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

  Container filterWidget(BuildContext context, HomePageViewModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const Expanded(
              child: SizedBox(
                height: 32,
                child: HomeSelectSportsWidget(),
              ),
            ),
            const VerticalDivider(
              width: 1,
              color: Color(0xFF333333),
            ),
            const SizedBox(width: 8),
            filterTapIcon(context, model),
          ],
        ),
      ),
    );
  }

  GestureDetector filterTapIcon(BuildContext context, HomePageViewModel model) {
    return GestureDetector(
      onTap: () {
        // showModalBottomSheet(
        //     useRootNavigator: true,
        //     context: context,
        //     isScrollControlled: true,
        //     backgroundColor: Colors.transparent,
        //     constraints: const BoxConstraints(minWidth: double.infinity),
        //     builder: (BuildContext context) {
        //       return const Wrap(children: [PartnerLevelBottomSheet()]);
        //     });
        showModalBottomSheet(
          useRootNavigator: true,
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          constraints: const BoxConstraints(minWidth: double.infinity),
          builder: (BuildContext context) {
            return const Wrap(children: [FilterBottomSheet()]);
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
