import 'package:flutter/material.dart';

enum Level { beginner, intermediate, advance, professional, coach }

class PartnerLevelBottomSheet extends StatefulWidget {
  const PartnerLevelBottomSheet({
    super.key,
  });

  @override
  State<PartnerLevelBottomSheet> createState() => _PartnerLevelBottomSheet();
}

class _PartnerLevelBottomSheet extends State<PartnerLevelBottomSheet> {
  var selectedLevel = Level.beginner;

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
                      'Sport Selected',
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
                'Select Partner\'s Level',
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
                  sportsRadioButtonWidget("Beginner", Level.beginner),
                  sportsRadioButtonWidget("Intermediate", Level.intermediate),
                  sportsRadioButtonWidget("Advance", Level.advance),
                  sportsRadioButtonWidget("Professional", Level.professional),
                  sportsRadioButtonWidget("Coach/Trainer", Level.coach)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  ListTile sportsRadioButtonWidget(String text, Level value) {
    return ListTile(
      onTap: () {
        setState(
          () {
            selectedLevel = value;
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
