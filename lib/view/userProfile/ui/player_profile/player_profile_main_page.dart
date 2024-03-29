import 'package:flutter/material.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/utils/utilities.dart';
import 'package:gear_up/view/userProfile/model/response/player_profile_response.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/about_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/details_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/plays_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/profession_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/ratings_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/review_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/social_handle_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/stats_card.dart';
import 'package:gear_up/view/userProfile/ui/user_profile/title_text.dart';
import 'package:gear_up/view/userProfile/viewmodel/profile_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../colors/Colors.dart';
import '../../../../data/response/status.dart';

class PlayerProfileScreen extends StatefulWidget {
  final String playerID;
  const PlayerProfileScreen({super.key, required this.playerID});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<ProfileViewModel>(context);
    if (!model.playerProfileApiCalled) {
      model.fetchPlayerProfile(widget.playerID);
      return const Center(child: CircularProgressIndicator());
    } else if (model.playerProfileReponse.status == Status.LOADING) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ui(context, model);
    }
  }

  Scaffold ui(BuildContext context, ProfileViewModel model) {
    return Scaffold(
      appBar: otherUserProfileAppBar(context, model),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserDetailsCard(
                userImage: model.playerProfileReponse.data?.user?.img,
                userName: model.playerProfileReponse.data?.user?.name,
                userAge: model.playerProfileReponse.data?.user?.age,
                userGender: model.playerProfileReponse.data?.user?.gender,
                userLocation:
                    model.playerProfileReponse.data?.user?.currentAddress?.name,
              ),
              const RatingCard(userRating: null),
              const SizedBox(height: 8),
              PlaysCard(
                sportslist:
                    model.playerProfileReponse.data?.user?.favoriteSports,
                onTap: () {},
                editable: false,
              ),
              const SizedBox(height: 8),
              AboutCard(
                  text: model.playerProfileReponse.data?.user?.bio,
                  onTap: () {},
                  editable: false),
              const SizedBox(height: 8),
              ProfessionCard(
                  text: model.playerProfileReponse.data?.user?.profession,
                  onTap: () {},
                  editable: false),
              const SizedBox(height: 32),
              const TitleText(text: 'Games Stats'),
              const SizedBox(height: 16),
              SizedBox(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: model
                          .playerProfileReponse.data?.user?.gameStats?.length ??
                      0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ExpandedTile(
                      gameStat: model.playerProfileReponse.data?.user
                              ?.gameStats?[index] ??
                          GameStat(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 32),
              const TitleText(text: 'Social Media'),
              const SizedBox(height: 16),
              SocialMediaCard(
                  text: 'Facebook',
                  icon: Icons.facebook,
                  isEditable: false,
                  link: model
                      .playerProfileReponse.data?.user?.socialMedia?.facebook),
              const SizedBox(height: 8),
              SocialMediaCard(
                  text: 'Instagram',
                  icon: Icons.facebook,
                  isEditable: false,
                  link: model
                      .playerProfileReponse.data?.user?.socialMedia?.instagram),
              const SizedBox(height: 8),
              SocialMediaCard(
                  text: 'Linkedin',
                  icon: Icons.facebook,
                  isEditable: false,
                  link: model
                      .playerProfileReponse.data?.user?.socialMedia?.linkedin),
              const SizedBox(height: 8),
              SocialMediaCard(
                  text: 'X(Twitter)',
                  icon: Icons.facebook,
                  isEditable: false,
                  link: model
                      .playerProfileReponse.data?.user?.socialMedia?.twitter),
              const SizedBox(height: 8),
              const SizedBox(height: 32),
              reviewsAndRatingsWidget(model),
              const SizedBox(height: 18),
              getActionButton(model),
              const SizedBox(height: 16)
            ],
          ),
        ),
      ),
    );
  }

  Widget getActionButton(ProfileViewModel model) {
    if (model.playerProfileReponse.data?.user?.connectionData?.connection ==
        false) {
      return CustomBigButtonLight(
          onTap: () {
            model.sendConnectionRequest(widget.playerID);
          },
          text:
              model.userConnectionStatus == 0 ? 'Sending Request' : 'Connect');
    } else {
      if (model.playerProfileReponse.data?.user?.connectionData
              ?.connectionStatus !=
          'Pending') {
        return CustomBigButtonLight(onTap: () {}, text: 'Chat');
      } else if (model
              .playerProfileReponse.data?.user?.connectionData?.isSender ==
          true) {
        return CustomBigButtonDark(
            onTap: () {
              model.removeConnectionRequest(widget.playerID);
            },
            text: 'Cancel Request');
      } else {
        return Column(
          children: [
            CustomBigButtonLight(
                onTap: () {
                  model.acceptConnectionRequest(widget.playerID);
                },
                text: 'Accept'),
            const SizedBox(
              height: 8,
            ),
            CustomBigButtonDark(
                onTap: () {
                  model.rejectConnectionRequest(widget.playerID);
                },
                text: 'Reject')
          ],
        );
      }
    }
  }

  Widget reviewsAndRatingsWidget(ProfileViewModel model) {
    final ratings = model.playerProfileReponse.data?.user?.ratings;
    if (ratings == null || ratings.isEmpty) {
      return Container();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TitleText(text: 'Reviews and Ratings'),
          const SizedBox(height: 16),
          SizedBox(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount:
                  model.playerProfileReponse.data?.user?.ratings?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ReviewCard(
                  rating:
                      model.playerProfileReponse.data?.user?.ratings?[index] ??
                          Rating(),
                );
              },
            ),
          ),
        ],
      );
    }
  }

  AppBar otherUserProfileAppBar(BuildContext context, ProfileViewModel model) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      centerTitle: false,
      toolbarHeight: 68,
      backgroundColor: cardBgColor,
      automaticallyImplyLeading: false,
      actions: [
        PopupMenuButton(
          onSelected: (value) {
            if (value == 1) {
              showSnackBar(context, "Share option coming in next release");
            }
          },
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8))),
          color: Colors.white,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(
                    Icons.share_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Share Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          ],
          child: Container(
            margin: const EdgeInsets.only(right: 18),
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
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ),
      ],
      title: InkWell(
        onTap: () {
          if (context.canPop()) {
            model.clearData();
            context.pop();
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 8, left: 8, right: 12, bottom: 8),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 1, color: Color(0xFF333333)),
              borderRadius: BorderRadius.circular(80),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.chevron_left, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
