import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/utilities.dart';

class ProfessionCard extends StatelessWidget {
  const ProfessionCard({
    super.key,
    required this.text,
    required this.onTap,
    required this.editable,
  });

  final String? text;
  final Function onTap;
  final bool editable;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: cardBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Profession',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                uiText(text),
                style: const TextStyle(
                  color: Color(0xFFCBCBCB),
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
              editable == true
                  ? GestureDetector(
                      onTap: () {
                        onTap();
                      },
                      child: const Icon(
                        Icons.add_circle_outline,
                        size: 20,
                      ))
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}
