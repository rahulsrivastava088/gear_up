import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/view/bottomNavigation/custom.dart';

class PoshCard extends StatelessWidget {
  const PoshCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        CustomNavigationHelper.router.push(CustomNavigationHelper.poshPath);
      },
      child: Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            color: cardBgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 12),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Go to Posh Training Screen',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'General Sans',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(Icons.chevron_right, size: 20)
            ],
          )),
    );
  }
}
