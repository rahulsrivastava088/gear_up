import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/view/partners/ui/app_bar.dart';
import 'package:gear_up/view/partners/ui/filter_bottom_sheet.dart';
import 'package:gear_up/view/partners/ui/sports_filter.dart';
import 'package:gear_up/view/partners/viewModel/partners_page_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../data/response/status.dart';
import '../../../project/routes/app_route_constants.dart';
import '../../bottomNavigation/custom.dart';

class PartnersScreen extends StatefulWidget {
  const PartnersScreen({super.key});

  @override
  State<PartnersScreen> createState() => _PartnersScreenState();
}

class _PartnersScreenState extends State<PartnersScreen> {
  final String userRating = '4.8';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PartnersPageViewModel>(context);
    // return _shimmerUi(context);
    if (!model.apiCalled) {
      model.fetchAllPlayers(context);
      return _shimmerUi(context);
    } else if (model.playersListResponse.status == Status.LOADING) {
      return _shimmerUi(context);
    } else {
      return ui(context, model);
    }
  }
  //

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

  Scaffold ui(BuildContext context, PartnersPageViewModel model) {
    return Scaffold(
      appBar: partnersAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Column(children: [
          filterWidget(context),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: model.playersListResponse.data?.playersWithConnections
                      ?.length ??
                  0,
              // controller: PageController(viewportFraction: 0.8),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      CustomNavigationHelper.router.push(
                          CustomNavigationHelper.playerProfilePath,
                          extra: model.playersListResponse.data
                              ?.playersWithConnections?[index].id);
                    },
                    child: Row(
                      children: [
                        Center(
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(24), // Image radius
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/person_image.png',
                                image: model.playersListResponse.data
                                        ?.playersWithConnections?[index].img ??
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
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Color(0xFF333333)),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  model
                                          .playersListResponse
                                          .data
                                          ?.playersWithConnections?[index]
                                          .firstName ??
                                      "-",
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
                                      '22, ${model.playersListResponse.data?.playersWithConnections?[index].gender ?? "-"} • ${model.playersListResponse.data?.playersWithConnections?[index].distance ?? '-' 'km away'}',
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
                    ));
              },
            ),
          ),
        ]),
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
