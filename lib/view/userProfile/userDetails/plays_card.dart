import 'package:flutter/material.dart';

class PlaysCard extends StatelessWidget {
  const PlaysCard({
    super.key,
    required this.sportslist,
    required this.onTap,
  });

  final List<String> sportslist;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: const Color(0xFF141414),
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
            'Plays',
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
                getStringFromSportsList(sportslist),
                style: const TextStyle(
                  color: Color(0xFFCBCBCB),
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w400,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    onTap;
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 20,
                  ))
            ],
          )
        ],
      ),
    );
  }
}

String getStringFromSportsList(List<String> sportslist) {
  return sportslist.join(',');
}
