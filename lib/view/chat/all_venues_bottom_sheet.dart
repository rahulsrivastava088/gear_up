import 'package:flutter/material.dart';
import 'package:gear_up/utils/uiUtils/big_button.dart';
import 'package:go_router/go_router.dart';

class AllVenuesBottomSheet extends StatefulWidget {
  const AllVenuesBottomSheet({
    super.key,
  });

  @override
  State<AllVenuesBottomSheet> createState() => _AllVenuesBottomSheet();
}

class _AllVenuesBottomSheet extends State<AllVenuesBottomSheet> {
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'All Venues',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 132,
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                decoration: ShapeDecoration(
                  color: const Color(0xFFF6F6F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Venues widget",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 38),
              Container(
                width: double.infinity,
                height: 80,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomBigButtonGrey(
                        onTap: () {
                          context.pop();
                        },
                        text: "Back",
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: CustomBigButtonDark(onTap: () {}, text: 'Done'))
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
