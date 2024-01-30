import 'package:flutter/material.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';

import 'all_venues_bottom_sheet.dart';

class ScheduleMatchBottomSheet extends StatefulWidget {
  const ScheduleMatchBottomSheet({
    super.key,
  });

  @override
  State<ScheduleMatchBottomSheet> createState() => _ScheduleMatchBottomSheet();
}

class _ScheduleMatchBottomSheet extends State<ScheduleMatchBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 24, bottom: 16, left: 24, right: 24),
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
                  bottom: 24,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Schedule a Match',
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
              _headerText("Date"),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Row(
                  children: [
                    Text(
                      '11 Nov, 2023',
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.calendar_month, color: Color(0xFF141414))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _headerText("Time"),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Row(
                  children: [
                    Text(
                      '8:30 PM',
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.schedule, color: Color(0xFF141414))
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _headerText("Game"),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                height: 36,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: const Row(
                  children: [
                    Text(
                      'Game widget',
                      style: TextStyle(
                        color: Color(0xFF6B6B6B),
                        fontSize: 14,
                        fontFamily: 'Space Grotesk',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(height: .5, color: Color(0xFFAFAFAF)),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Text(
                    'Suggested Venues',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'General Sans',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        useRootNavigator: true,
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        constraints:
                            const BoxConstraints(minWidth: double.infinity),
                        builder: (BuildContext context) {
                          return const Wrap(children: [AllVenuesBottomSheet()]);
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFE2E2E2)),
                          borderRadius: BorderRadius.circular(80),
                        ),
                      ),
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          color: Color(0xFF0095F6),
                          fontSize: 14,
                          fontFamily: 'Space Grotesk',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 26),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey,
                child: const Text("Venue Widget"),
              ),
              const SizedBox(height: 16),
              const Divider(height: .5, color: Color(0xFFAFAFAF)),
              const SizedBox(height: 16),
              CustomBigButtonDark(onTap: () {}, text: 'Send'),
            ],
          ),
        )
      ],
    );
  }

  Text _headerText(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF3D3D3D),
        fontSize: 12,
        fontFamily: 'Space Grotesk',
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
