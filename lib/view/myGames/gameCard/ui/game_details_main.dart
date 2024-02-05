import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/utils/strings.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:gear_up/view/myGames/gameCard/ui/game_details_app_bar.dart';
import 'package:gear_up/view/myGames/gameCard/ui/game_rate_radio_button.dart';
import 'package:gear_up/view/myGames/gameCard/viewmodel/game_card_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../utils/utilities.dart';
import '../model/response/games_list_response.dart';
import '../viewmodel/game_details_view_model.dart';
import 'game_winner_radio_button.dart';

enum RateSkills { beginner, intermediate, pro }

enum Punctuality { beforeTime, onTime, late }

enum SportsManShip { excellent, average, bad }

enum TeamPlayer { excellent, average, bad }

enum Competitiveness { high, average, bad }

enum Respectful { excellent, average, bad }

class GameDetailsPage extends StatefulWidget {
  final Game game;
  const GameDetailsPage({super.key, required this.game});

  @override
  State<GameDetailsPage> createState() => _GameDetailsPageState();
}

class _GameDetailsPageState extends State<GameDetailsPage> {
  @override
  void initState() {
    super.initState();
    game = widget.game;
  }

  Game game = Game();
  TextEditingController matchesPlayedController = TextEditingController();
  TextEditingController matchesWonController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  int winnerIndex = -1;
  int rateSkillsIndex = -1;
  int punctualityIndex = -1;
  int sportsmanshipIndex = -1;
  int teamPlayerIndex = -1;
  int competitivenessIndex = -1;
  int respectfulIndex = -1;
  bool showProgressIndicator = false;

  void _toggleProgressIndicator() {
    setState(() {
      showProgressIndicator = !showProgressIndicator;
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GameCardViewModel>(context);
    final gameModel = Provider.of<GameDetailsViewModel>(context);
    return Stack(
      children: [
        ui(
          context,
          model,
          game,
          gameModel,
        ),
        if (showProgressIndicator)
          Stack(children: [
            ModalBarrier(
              color: Colors.black.withOpacity(0.5),
              dismissible: false,
            ),
            Center(
              child: Container(
                width: 280,
                height: 280,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Updating Scorecard',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ]),
      ],
    );
  }

  Scaffold ui(BuildContext context, GameCardViewModel model, Game game,
      GameDetailsViewModel gameModel) {
    return Scaffold(
      appBar: gameCardAppBar(context, game),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noteWidget(),
              matchInfoWidget(),
              scoreCardWidget(),
              gameStatsWidget(gameModel),
              reviewReceivedWidget(),
              partnerFeedbackWidget(gameModel),
            ],
          ),
        ),
      ),
    );
  }

  Widget partnerFeedbackWidget(GameDetailsViewModel gameModel) {
    if (game.status != "Recent") {
      return const Column();
    }
    return shouldPartnerFeedBackBeVisible() == true
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading('Partner Feedback'),
              (game.isHost == true &&
                          game.player1Feedback?.reviewMessage != null) ||
                      (game.isHost == false &&
                          game.player2Feedback?.reviewMessage != null)
                  ? text1('You have given this review')
                  : Container(),
              const SizedBox(height: 12),
              (game.isHost == true &&
                          game.player1Feedback?.reviewMessage != null) ||
                      (game.isHost == false &&
                          game.player2Feedback?.reviewMessage != null)
                  ? reviewGivenTextCard()
                  : Container(),
              (game.isHost == true && game.player1Feedback?.updated == false) ||
                      (game.isHost == false &&
                          game.player2Feedback?.updated == false)
                  ? partnerFeedBackCard(gameModel)
                  : Container(),
            ],
          )
        : Container();
  }

  bool shouldPartnerFeedBackBeVisible() {
    if (game.isHost == true) {
      if (game.player1Feedback?.updated == true) {
        if (game.player1Feedback?.reviewMessage != null) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      if (game.player2Feedback?.updated == true) {
        if (game.player2Feedback?.reviewMessage != null) {
          return true;
        }
      } else {
        return true;
      }
    }
    return false;
  }

  Widget reviewReceivedWidget() {
    if (game.status != "Recent") {
      return const Column();
    }
    if (game.isHost == true && game.player2Feedback?.reviewMessage == null) {
      return Container();
    } else if (game.isHost == false &&
        game.player1Feedback?.reviewMessage == null) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading('Review Received'),
        text1('Your partner has given this review'),
        const SizedBox(height: 12),
        reviewReceivedTextCard(),
        const SizedBox(height: 32),
      ],
    );
  }

  Column gameStatsWidget(GameDetailsViewModel gameModel) {
    if (game.status != "Recent") {
      return const Column();
    }
    if (game.isHost == true && game.scorecard?.updated == false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          gameStatsHeading(gameModel),
          const SizedBox(height: 12),
          gameStasCard(),
          const SizedBox(height: 32),
        ],
      );
    } else {
      return const Column();
    }
  }

  Column scoreCardWidget() {
    if (game.status != "Recent") {
      return const Column();
    }
    if (game.isHost == true && game.scorecard?.updated == false) {
      return const Column();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          heading('Scorecard'),
          game.scorecard?.updated == true
              ? Container()
              : text1('Not updated yet'),
          const SizedBox(height: 12),
          scoreCardInfoCard(),
          const SizedBox(height: 32),
        ],
      );
    }
  }

  Column matchInfoWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading('Match Info'),
        const SizedBox(height: 12),
        matchInfoCard(),
        const SizedBox(height: 32)
      ],
    );
  }

  Column noteWidget() {
    if (game.status != "Recent") {
      return const Column();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        noteCard(),
        const SizedBox(height: 16),
      ],
    );
  }

  Row gameStatsHeading(GameDetailsViewModel gameModel) {
    return Row(
      children: [
        heading('Game Stats'),
        const Spacer(),
        saveButton(gameModel),
        const SizedBox(width: 4)
      ],
    );
  }

  Container partnerFeedBackCard(GameDetailsViewModel gameModel) {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rateSkillsCard(),
          const SizedBox(height: 36),
          punctualityCard(),
          const SizedBox(height: 36),
          sportsmanshipCard(),
          const SizedBox(height: 36),
          teamPlayerCard(),
          const SizedBox(height: 36),
          competitivenessCard(),
          const SizedBox(height: 36),
          respectfulCard(),
          const SizedBox(height: 36),
          text3('Review'),
          const SizedBox(height: 10),
          reviewTextInput(),
          const SizedBox(height: 32),
          CustomBigButtonLight(
              onTap: () {
                if (isFeedBackValid()) {
                  _toggleProgressIndicator();
                  gameModel
                      .updateFeedBack(
                    context,
                    game.id,
                    game.isHost,
                    rateSkillsIndex,
                    punctualityIndex,
                    sportsmanshipIndex,
                    teamPlayerIndex,
                    competitivenessIndex,
                    respectfulIndex,
                    reviewController.text.trim(),
                  )
                      .then((value) {
                    // game = value;
                    _toggleProgressIndicator();
                  }).onError(
                    (error, stackTrace) {
                      _toggleProgressIndicator();
                    },
                  );
                } else {
                  showSnackBar(context, 'Invalid selection');
                }
              },
              text: 'Share FeedBack')
        ],
      ),
    );
  }

  Container reviewTextInput() {
    return Container(
      width: double.infinity,
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFF333333)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: TextField(
        controller: reviewController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          border: InputBorder.none,
          hintText: 'Write a review for your partner',
          hintStyle: TextStyle(
            color: Color(0xFF6B6B6B),
            fontSize: 14,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Column rateSkillsCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text3('Rate Skills'),
        text5('Gameplay, game awareness & adaptability'),
        const SizedBox(height: 10),
        rateSkillsSelector(),
      ],
    );
  }

  Column punctualityCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text3('Punctuality'),
        text5('Reaching venue, getting ready & finishing up'),
        const SizedBox(height: 10),
        punctualitySelector(),
      ],
    );
  }

  Column sportsmanshipCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text3('Sportsmanship'),
        text5('Fair play, courage & ethics'),
        const SizedBox(height: 10),
        sportsmanshipSelector(),
      ],
    );
  }

  Column teamPlayerCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text3('Team Player'),
        text5('Collaboration, supported & team oriented'),
        const SizedBox(height: 10),
        teamPlayerSelector(),
      ],
    );
  }

  Column competitivenessCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text3('Competitiveness'),
        text5('Desire to win, resilience & high standards'),
        const SizedBox(height: 10),
        competitivenessSelector(),
      ],
    );
  }

  Column respectfulCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        text3('Respectful'),
        text5('Towards partner & ground staff'),
        const SizedBox(height: 10),
        respectfulSelector(),
      ],
    );
  }

  Column rateSkillsSelector() {
    return Column(
      children: [
        GameRateListTile<int>(
          value: 0,
          groupValue: rateSkillsIndex,
          title: text2('Beginner'),
          onChanged: (value) => setState(() => rateSkillsIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 1,
          groupValue: rateSkillsIndex,
          title: text2('Intermediate'),
          onChanged: (value) => setState(() => rateSkillsIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 2,
          groupValue: rateSkillsIndex,
          title: text2('Pro'),
          onChanged: (value) => setState(() => rateSkillsIndex = value!),
        ),
      ],
    );
  }

  Column punctualitySelector() {
    return Column(
      children: [
        GameRateListTile<int>(
          value: 0,
          groupValue: punctualityIndex,
          title: text2('Before Time'),
          onChanged: (value) => setState(() => punctualityIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 1,
          groupValue: punctualityIndex,
          title: text2('On Time'),
          onChanged: (value) => setState(() => punctualityIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 2,
          groupValue: punctualityIndex,
          title: text2('Late'),
          onChanged: (value) => setState(() => punctualityIndex = value!),
        ),
      ],
    );
  }

  Column sportsmanshipSelector() {
    return Column(
      children: [
        GameRateListTile<int>(
          value: 0,
          groupValue: sportsmanshipIndex,
          title: text2('Excellent'),
          onChanged: (value) => setState(() => sportsmanshipIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 1,
          groupValue: sportsmanshipIndex,
          title: text2('Average'),
          onChanged: (value) => setState(() => sportsmanshipIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 2,
          groupValue: sportsmanshipIndex,
          title: text2('Bad'),
          onChanged: (value) => setState(() => sportsmanshipIndex = value!),
        ),
      ],
    );
  }

  Column teamPlayerSelector() {
    return Column(
      children: [
        GameRateListTile<int>(
          value: 0,
          groupValue: teamPlayerIndex,
          title: text2('Excellent'),
          onChanged: (value) => setState(() => teamPlayerIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 1,
          groupValue: teamPlayerIndex,
          title: text2('Average'),
          onChanged: (value) => setState(() => teamPlayerIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 2,
          groupValue: teamPlayerIndex,
          title: text2('Bad'),
          onChanged: (value) => setState(() => teamPlayerIndex = value!),
        ),
      ],
    );
  }

  Column competitivenessSelector() {
    return Column(
      children: [
        GameRateListTile<int>(
          value: 0,
          groupValue: competitivenessIndex,
          title: text2('High'),
          onChanged: (value) => setState(() => competitivenessIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 1,
          groupValue: competitivenessIndex,
          title: text2('Average'),
          onChanged: (value) => setState(() => competitivenessIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 2,
          groupValue: competitivenessIndex,
          title: text2('Low'),
          onChanged: (value) => setState(() => competitivenessIndex = value!),
        ),
      ],
    );
  }

  Column respectfulSelector() {
    return Column(
      children: [
        GameRateListTile<int>(
          value: 0,
          groupValue: respectfulIndex,
          title: text2('Excellent'),
          onChanged: (value) => setState(() => respectfulIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 1,
          groupValue: respectfulIndex,
          title: text2('Average'),
          onChanged: (value) => setState(() => respectfulIndex = value!),
        ),
        const SizedBox(width: 8),
        GameRateListTile<int>(
          value: 2,
          groupValue: respectfulIndex,
          title: text2('Bad'),
          onChanged: (value) => setState(() => respectfulIndex = value!),
        ),
      ],
    );
  }

  Text radioButtonText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text text5(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFAFAFAF),
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Container gameStasCard() {
    return Container(
        width: double.infinity,
        decoration: cardDecoration(),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text3('Match Winner'),
            const SizedBox(height: 8),
            Wrap(
              spacing: 0.0, // Horizontal spacing between children
              runSpacing: 0.0,
              children: [
                Expanded(
                  child: GameWinnerListTile<int>(
                    value: 1,
                    groupValue: winnerIndex,
                    title: text2('You'),
                    onChanged: (value) => setState(() => winnerIndex = value!),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GameWinnerListTile<int>(
                    value: 2,
                    groupValue: winnerIndex,
                    title: text2(game.player2?.name ?? '-'),
                    onChanged: (value) => setState(() => winnerIndex = value!),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GameWinnerListTile<int>(
                    value: 3,
                    groupValue: winnerIndex,
                    title: text2('Draw'),
                    onChanged: (value) => setState(() => winnerIndex = value!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            text3('Score'),
            const SizedBox(height: 10),
            text4('Matches Played'),
            const SizedBox(height: 6),
            matchesPlayedInputText(),
            const SizedBox(height: 16),
            text4('Matches Won'),
            const SizedBox(height: 6),
            matchesWonInputText(),
          ],
        ));
  }

  Container matchesWonInputText() {
    return Container(
      width: double.infinity,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: cardBgColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: TextField(
        controller: matchesWonController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          border: InputBorder.none,
          hintText: 'Matches Won',
          hintStyle: TextStyle(
            color: Color(0xFF6B6B6B),
            fontSize: 14,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Container matchesPlayedInputText() {
    return Container(
      width: double.infinity,
      height: 36,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: ShapeDecoration(
        color: cardBgColorLight,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: TextField(
        controller: matchesPlayedController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.start,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w400,
        ),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.zero,
          isDense: true,
          border: InputBorder.none,
          hintText: 'Matches Played',
          hintStyle: TextStyle(
            color: Color(0xFF6B6B6B),
            fontSize: 14,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Text text4(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFCBCBCB),
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Text text3(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  GestureDetector saveButton(GameDetailsViewModel gameModel) {
    return GestureDetector(
      onTap: () {
        if (winnerIndex == 0) {
          showSnackBar(context, 'Please select Match Winner');
        } else if (matchesPlayedController.text.trim().isEmpty) {
          showSnackBar(context, 'Please enter matches played');
        } else if (matchesWonController.text.trim().isEmpty) {
          showSnackBar(context, 'Please enter matches won');
        } else if (!isScoreCardValid()) {
          showSnackBar(context, 'Invalid selection');
        } else {
          _toggleProgressIndicator();
          gameModel
              .updateGameStats(
            context,
            game.id,
            int.parse(matchesPlayedController.text.trim()),
            int.parse(matchesWonController.text.trim()),
            winnerID(),
          )
              .then((value) {
            // game = value;
            _toggleProgressIndicator();
          }).onError((error, stackTrace) {
            _toggleProgressIndicator();
          });
        }
      },
      child: const Text(
        'Save',
        style: TextStyle(
          color: Color(0xFF299EE0),
          fontSize: 16,
          fontFamily: 'Space Grotesk',
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  bool isScoreCardValid() {
    int matchesPlayed = int.parse(matchesPlayedController.text.trim());
    int matchesWon = int.parse(matchesWonController.text.trim());
    if (winnerIndex == 1) {
      if (matchesWon * 2 > matchesPlayed) {
        return true;
      } else {
        return false;
      }
    } else if (winnerIndex == 2) {
      if (matchesWon * 2 < matchesPlayed) {
        return true;
      } else {
        return false;
      }
    } else if (winnerIndex == 3) {
      if (matchesPlayed % 2 != 0) {
        return false;
      } else if (matchesWon == matchesPlayed / 2) {
        return true;
      }
    }
    return false;
  }

  bool isFeedBackValid() {
    if (rateSkillsIndex == -1 ||
        punctualityIndex == -1 ||
        sportsmanshipIndex == -1 ||
        teamPlayerIndex == -1 ||
        competitivenessIndex == -1 ||
        respectfulIndex == -1) {
      return false;
    }
    return true;
  }

  String? winnerID() {
    switch (winnerIndex) {
      case 0:
        return null;
      case 1:
        return myUserID;
      case 2:
        return game.player2?.id;
      case 3:
        return null;
    }
    return null;
  }

  Container matchInfoCard() {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text1('Match'),
              const SizedBox(height: 8),
              text1('Date'),
              const SizedBox(height: 8),
              text1('Time'),
              const SizedBox(height: 8),
              text1('Venue')
            ],
          ),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text2(getSportName(game.sport?.id)),
              const SizedBox(height: 8),
              text2(game.matchDate != null ? convertDate(game.matchDate) : '-'),
              const SizedBox(height: 8),
              text2(formatEpochToTime(game.matchDate)),
              const SizedBox(height: 8),
              text2(game.venue?.name ?? '-'),
            ],
          ),
        ],
      ),
    );
  }

  Container scoreCardInfoCard() {
    return Container(
      width: double.infinity,
      decoration: cardDecoration(),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text1('Winner'),
              const SizedBox(height: 8),
              text1('Matches'),
              const SizedBox(height: 8),
              text1('You Won')
            ],
          ),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text2(game.scorecard?.winner ?? 'NA'),
              const SizedBox(height: 8),
              text2(game.scorecard?.matchesPlayed?.toString() ?? 'NA'),
              const SizedBox(height: 8),
              text2(game.scorecard?.matchesWonByPlayer2?.toString() ?? 'NA'),
            ],
          ),
        ],
      ),
    );
  }

  Text text2(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text text1(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFCBCBCB),
        fontSize: 14,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w400,
      ),
    );
  }

  ShapeDecoration cardDecoration() {
    return ShapeDecoration(
      color: cardBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Text heading(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'General Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Container noteCard() {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: cardBgColorLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Note:',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Winner update & your reviews will be shared to your partner. So make sure to be honest and clear with it.',
              style: TextStyle(
                color: Color(0xFFAFAFAF),
                fontSize: 12,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container reviewReceivedTextCard() {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: cardBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            game.isHost == true
                ? game.player2Feedback?.reviewMessage ?? '-'
                : game.player1Feedback?.reviewMessage ?? '-',
            style: const TextStyle(
              color: Color(0xFFCBCBCB),
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Container reviewGivenTextCard() {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: cardBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            game.player1Feedback?.reviewMessage ?? '',
            style: const TextStyle(
              color: Color(0xFFCBCBCB),
              fontSize: 14,
              fontFamily: 'Space Grotesk',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
