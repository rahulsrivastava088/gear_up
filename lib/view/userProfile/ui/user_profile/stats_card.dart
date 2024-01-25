import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';
import 'package:gear_up/view/userProfile/model/player_profile_response.dart';
import '../../../../utils/extension_functions.dart';

class ExpandedTile extends StatefulWidget {
  final GameStat gameStat;
  const ExpandedTile({
    super.key,
    required this.gameStat,
  });

  @override
  State<ExpandedTile> createState() => _ExpandedTileState();
}

class _ExpandedTileState extends State<ExpandedTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardBgColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.zero,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: (value) {
              setState(() {
                isExpanded = value;
              });
            },
            title: _unexpandedState(),
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _smallText('Played'),
                      _boldTextInt(widget.gameStat.matchesPlayed)
                    ],
                  ),
                  const SizedBox(width: 72),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _smallText('Won'),
                      _boldTextInt(widget.gameStat.matchesWon)
                    ],
                  ),
                  const SizedBox(width: 72),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _smallText('Rates as'),
                      _boldText(widget.gameStat.level ?? 'NA')
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }

  Widget _unexpandedState() {
    return Row(
      children: [
        Text(
          getSportName(widget.gameStat.sportId),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'General Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        // const Spacer(),
        // isExpanded
        //     ? const Icon(Icons.arrow_right_sharp, color: Colors.white)
        //     : const Icon(Icons.expand_less, color: Colors.white)
      ],
    );
  }
}

Text _smallText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Color(0xFFCBCBCB),
      fontSize: 12,
      fontFamily: 'Space Grotesk',
      fontWeight: FontWeight.w400,
    ),
  );
}

Text _boldText(String text) {
  return Text(
    text,
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'General Sans',
      fontWeight: FontWeight.w600,
    ),
  );
}

Text _boldTextInt(int? text) {
  return Text(
    text == null ? "NA" : text.toString(),
    style: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'General Sans',
      fontWeight: FontWeight.w600,
    ),
  );
}
