import 'package:flutter/material.dart';
import 'package:gear_up/view/onBoarding/commonUI/country_code_bottom_sheet.dart';

class SelectCountryCode extends StatelessWidget {
  const SelectCountryCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                constraints: const BoxConstraints(minWidth: double.infinity),
                builder: (BuildContext context) {
                  return const Wrap(children: [CountryCodeBottomSheet()]);
                });
          },
          child: Ink(
            width: double.infinity,
            height: 44,
            padding: const EdgeInsets.only(
              top: 8,
              left: 12,
              right: 12,
              bottom: 12,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              border: Border(
                // left: BorderSide(color: Color(0xFF333333)),
                // top: BorderSide(color: Color(0xFF333333)),
                // right: BorderSide(color: Color(0xFF333333)),
                bottom: BorderSide(width: 1, color: Color(0xFF333333)),
              ),
            ),
            child: const Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'India',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Space Grotesk',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_downward)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
