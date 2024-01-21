import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/utils/extension_functions.dart';
import 'package:gear_up/view/userProfile/model/player_profile_response.dart';

class PlaysCard extends StatelessWidget {
  const PlaysCard({
    super.key,
    required this.sportslist,
    required this.onTap,
    required this.editable,
  });

  final List<FavoriteSport>? sportslist;
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
                getStringFromFavoriteSportsList(sportslist),
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
                        Icons.edit_outlined,
                        size: 20,
                      ),
                    )
                  : Container()
            ],
          )
        ],
      ),
    );
  }
}

String getStringFromFavoriteSportsList(List<FavoriteSport>? sportslist) {
  var result = '';
  for (final sportname in sportslist ?? []) {
    result += "${getSportName(sportname.sport)}, ";
  }
  if (result.isEmpty) return "NA";
  return result.substring(0, result.length - 2);
}
