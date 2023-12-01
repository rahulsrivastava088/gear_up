import 'package:flutter/material.dart';
import 'package:gear_up/colors/Colors.dart';

class ExpandedTile extends StatefulWidget {
  final String sportsName;
  final String played;
  final String won;
  final String rate;
  const ExpandedTile(
      {super.key,
      required this.sportsName,
      required this.played,
      required this.won,
      required this.rate});

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
            trailing: const SizedBox(height: 26),
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_smallText('Played'), _boldText(widget.played)],
                  ),
                  const Spacer(flex: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_smallText('Won'), _boldText(widget.won)],
                  ),
                  const Spacer(flex: 3),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_smallText('Rates as'), _boldText(widget.rate)],
                  ),
                  const Spacer(flex: 4),
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
          widget.sportsName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'General Sans',
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        isExpanded
            ? const Icon(Icons.arrow_right_sharp, color: Colors.white)
            : const Icon(Icons.arrow_upward_sharp, color: Colors.white)
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
