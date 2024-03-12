import 'package:flutter/material.dart';
import 'package:gear_up/data/response/api_response.dart';
import 'package:gear_up/view/filter/filter_view_model.dart';
import 'package:gear_up/view/home/viewModel/home_page_view_model.dart';
import 'package:provider/provider.dart';
import '../../../utils/Strings.dart';
import '../../partners/ui/filter_bottom_sheet.dart';

class PartnerLevelBottomSheet extends StatefulWidget {
  final int selectedSportIndex;

  const PartnerLevelBottomSheet({
    super.key,
    required this.selectedSportIndex,
  });

  @override
  State<PartnerLevelBottomSheet> createState() => _PartnerLevelBottomSheet();
}

class _PartnerLevelBottomSheet extends State<PartnerLevelBottomSheet> {
  var selectedLevel = Level.beginner;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FilterViewModel>(context);
    final playerViewModel = Provider.of<PlayersViewModel>(context);
    if (model.favouriteSport == Sports.values[widget.selectedSportIndex]) {
      selectedLevel = model.favouriteSportLevel;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 24, left: 24, right: 24),
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.sportsList[widget.selectedSportIndex],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Select Your Level',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 8),
                  sportsRadioButtonWidget(
                    "Beginner",
                    Level.beginner,
                    model,
                    playerViewModel,
                  ),
                  sportsRadioButtonWidget(
                    "Intermediate",
                    Level.intermediate,
                    model,
                    playerViewModel,
                  ),
                  sportsRadioButtonWidget(
                    "Advance",
                    Level.advance,
                    model,
                    playerViewModel,
                  ),
                  sportsRadioButtonWidget(
                    "Professional",
                    Level.professional,
                    model,
                    playerViewModel,
                  ),
                  sportsRadioButtonWidget(
                    "Coach/Trainer",
                    Level.coachTrainer,
                    model,
                    playerViewModel,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListTile sportsRadioButtonWidget(String text, Level value,
      FilterViewModel model, PlayersViewModel playerViewModel) {
    return ListTile(
      onTap: () {
        setState(
          () {
            selectedLevel = value;
            model.favouriteSport = Sports.values[widget.selectedSportIndex];
            model.favouriteSportLevel = value;
            playerViewModel.playersListResponse = ApiResponse.idle();
            playerViewModel.notifyListeners();
            Navigator.pop(context);
          },
        );
      },
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.zero,
      title: Transform.translate(
        offset: const Offset(-16, 0),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Space Grotesk',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      leading: Radio(
        activeColor: Colors.black,
        value: value,
        groupValue: selectedLevel,
        onChanged: (value) {
          // setState(
          //   () {
          //     selectedSports = value!;
          //   },
          // );
        },
      ),
    );
  }
}
