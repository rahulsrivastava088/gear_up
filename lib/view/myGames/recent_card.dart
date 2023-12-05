import 'package:flutter/material.dart';

class RecentGameCard extends StatefulWidget {
  final String opponentName;
  final String sportsName;
  final String matchDate;
  final String result;
  const RecentGameCard(
      {super.key,
      required this.opponentName,
      required this.sportsName,
      required this.matchDate,
      required this.result});

  @override
  State<RecentGameCard> createState() => _RecentGameCard();
}

class _RecentGameCard extends State<RecentGameCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16),
          decoration: ShapeDecoration(
            color: const Color(0xFF141414),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'You/',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Space Grotesk',
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.opponentName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'General Sans',
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        Text(
                          widget.result,
                          style: const TextStyle(
                            color: Color(0xFF0095F6),
                            fontSize: 12,
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const VerticalDivider(
                          color: Color(0xFF333333),
                          thickness: 1,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          widget.matchDate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF1E1E1E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    child: Text(
                      widget.sportsName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
