import 'package:flutter/material.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/filter/filter_view_model.dart';
import 'package:gear_up/view/partners/ui/select_level_filter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum Gender { All, Male }

enum Sports { badminton, tableTennis, pool, lawnTennis, squash }

enum Level { beginner, intermediate, advance, professional, coachTrainer }

class FilterBottomSheet extends StatefulWidget {
  final Function onTap;
  final double selectedDistance;
  final double selectedStartAge;
  final double selectedEndAge;
  final Gender selectedGender;
  final Sports selectedSports;
  final Level selectedLevel;

  const FilterBottomSheet(
      {super.key,
      required this.onTap,
      required this.selectedDistance,
      required this.selectedStartAge,
      required this.selectedEndAge,
      required this.selectedGender,
      required this.selectedSports,
      required this.selectedLevel});

  @override
  State<FilterBottomSheet> createState() {
    return _FilterBottomSheet();
  }
}

class _FilterBottomSheet extends State<FilterBottomSheet> {
  double minimumDistance = 0;
  double maximumDistance = 50;
  double minAge = 18;
  double maxAge = 60;

  double selectedDistance = 10;
  double selectedStartAge = 18;
  double selectedEndAge = 24;
  var selectedGender = Gender.All;
  var selectedSports = Sports.badminton;
  var selectedLevel = Level.beginner;

  @override
  void initState() {
    super.initState();
    selectedDistance = widget.selectedDistance;
    selectedStartAge = widget.selectedStartAge;
    selectedEndAge = widget.selectedEndAge;
    selectedGender = widget.selectedGender;
    selectedSports = widget.selectedSports;
    selectedLevel = widget.selectedLevel;
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<FilterViewModel>(context);
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
                    const Text(
                      'Filters',
                      style: TextStyle(
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
              SizedBox(
                height: 600,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Games',
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
                              "Badminton", Sports.badminton, model),
                          sportsRadioButtonWidget(
                              "Table Tennis", Sports.tableTennis, model),
                          sportsRadioButtonWidget(
                              "Pool/Snooker", Sports.pool, model),
                          sportsRadioButtonWidget(
                              "Lawn Tennis", Sports.lawnTennis, model),
                          sportsRadioButtonWidget(
                              "Squash", Sports.squash, model),
                        ],
                      ),
                      const SizedBox(height: 42),
                      const Text(
                        'Range',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'General Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${selectedDistance.toInt()} Kms',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '(max: ${maximumDistance.toInt()}km)',
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 6,
                            trackShape: const RectangularSliderTrackShape(),
                            activeTrackColor: Colors.black,
                            inactiveTrackColor: const Color(0xFFAFAFAF),
                            thumbColor: Colors.white,
                            overlayShape: SliderComponentShape.noThumb,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8),
                          ),
                          child: Slider(
                            divisions:
                                (maximumDistance - minimumDistance).toInt(),
                            min: minimumDistance,
                            max: maximumDistance,
                            value: selectedDistance,
                            onChanged: (value) {
                              setState(() {
                                selectedDistance = value;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 42),
                      const Text(
                        'Age Group',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'General Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${selectedStartAge.toInt()}-${selectedEndAge.toInt()} Yrs',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '(min: ${minAge.toInt()} Yrs)',
                              style: const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontFamily: 'Space Grotesk',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.only(left: 2, right: 2),
                        child: SliderTheme(
                          data: SliderThemeData(
                            trackHeight: 6,
                            trackShape: const RectangularSliderTrackShape(),
                            activeTrackColor: Colors.black,
                            inactiveTrackColor: const Color(0xFFAFAFAF),
                            thumbColor: Colors.white,
                            overlayShape: SliderComponentShape.noThumb,
                            thumbShape: const RoundSliderThumbShape(
                                enabledThumbRadius: 8),
                          ),
                          child: RangeSlider(
                            divisions: (maxAge - minAge).toInt(),
                            min: minAge,
                            max: maxAge,
                            values:
                                RangeValues(selectedStartAge, selectedEndAge),
                            onChanged: (value) {
                              setState(() {
                                selectedStartAge = value.start;
                                selectedEndAge = value.end;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 42),
                      const Text(
                        'Gender',
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
                          ListTile(
                            onTap: () {
                              setState(
                                () {
                                  selectedGender = Gender.All;
                                },
                              );
                            },
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: Transform.translate(
                              offset: const Offset(-16, 0),
                              child: const Text(
                                "All Gender",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Space Grotesk',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            leading: Radio(
                              activeColor: Colors.black,
                              value: Gender.All,
                              groupValue: selectedGender,
                              onChanged: (value) {},
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              setState(
                                () {
                                  selectedGender = Gender.Male;
                                },
                              );
                            },
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -4),
                            contentPadding: EdgeInsets.zero,
                            title: Transform.translate(
                              offset: const Offset(-16, 0),
                              child: const Text(
                                "Male",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Space Grotesk',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            leading: Radio(
                              activeColor: Colors.black,
                              value: Gender.Male,
                              groupValue: selectedGender,
                              onChanged: (value) {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        context.pop();
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF6F6F6),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        model.gender = selectedGender;
                        model.maxAge = maxAge.toInt();
                        model.minAge = minAge.toInt();
                        model.range = selectedDistance.toInt();
                        model.favouriteSport = selectedSports;
                        widget.onTap();
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 48,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        decoration: ShapeDecoration(
                          color: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text(
                          'Save Changes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'General Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget sportsRadioButtonWidget(
      String text, Sports value, FilterViewModel model) {
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(
              () {
                selectedSports = value;
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
            groupValue: selectedSports,
            onChanged: (value) {
              // setState(
              //   () {
              //     selectedSports = value!;
              //   },
              // );
            },
          ),
        ),
        value == selectedSports ? const SelectLevelFilterWidget() : Container()
      ],
    );
  }
}
