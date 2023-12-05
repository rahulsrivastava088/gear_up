import 'package:flutter/material.dart';
import 'package:gear_up/utils/strings.dart';

enum Gender { allGender, male }

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    super.key,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheet();
}

class _FilterBottomSheet extends State<FilterBottomSheet> {
  String selectedSports = Strings.sportsList[0];
  double selectedDistance = 10;
  double minimumDistance = 0;
  double maximumDistance = 50;

  double minAge = 18;
  double maxAge = 60;
  double selectedStartAge = 18;
  double selectedEndAge = 24;

  var selectedGender = Gender.allGender;

  @override
  Widget build(BuildContext context) {
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
                      'Select a location',
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
              const Text(
                'Games',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Text(Strings.sportsList[0]),
                  Text(Strings.sportsList[1]),
                  Text(Strings.sportsList[2]),
                  Text(Strings.sportsList[3]),
                  Text(Strings.sportsList[4])
                  // ListTile(
                  //   title: Text(Strings.sportsList[0]),
                  //   leading: Radio(
                  //     value: Text(Strings.sportsList[0]),
                  //     groupValue: selectedSports,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedSports = value;
                  //       });
                  //     },
                  //   ),
                  // ),
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
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: Slider(
                    divisions: (maximumDistance - minimumDistance).toInt(),
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
                    thumbShape:
                        const RoundSliderThumbShape(enabledThumbRadius: 8),
                  ),
                  child: RangeSlider(
                    divisions: (maxAge - minAge).toInt(),
                    min: minAge,
                    max: maxAge,
                    values: RangeValues(selectedStartAge, selectedEndAge),
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
                  ListTile(
                    title: const Text("All Gender"),
                    leading: Radio(
                      value: Gender.allGender,
                      groupValue: selectedGender,
                      onChanged: (gender) {
                        setState(
                          () {
                            selectedGender = gender!;
                          },
                        );
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Male"),
                    leading: Radio(
                      value: Gender.male,
                      groupValue: selectedGender,
                      onChanged: (gender) {
                        setState(
                          () {
                            selectedGender = gender!;
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {},
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
                      onPressed: () {},
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
}
