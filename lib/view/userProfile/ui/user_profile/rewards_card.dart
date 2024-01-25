import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';

class RewardsCard extends StatelessWidget {
  const RewardsCard({
    super.key,
    required this.bucks,
  });

  final int? bucks;

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rewards',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'General Sans',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${bucks ?? "NA"} bucks',
                style: const TextStyle(
                  color: Color(0xFFCBCBCB),
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Spacer(),
              const Icon(Icons.chevron_right, size: 20)
            ],
          )
        ],
      ),
    );
  }
}
