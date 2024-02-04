import 'dart:async';

import 'package:flutter/material.dart';

class EditCancelGameBottomSheet extends StatefulWidget {
  final Completer<int> completer;
  final bool isAccepted;

  const EditCancelGameBottomSheet({
    super.key,
    required this.completer,
    required this.isAccepted,
  });

  @override
  State<EditCancelGameBottomSheet> createState() =>
      _EditCancelGameBottomSheet();
}

class _EditCancelGameBottomSheet extends State<EditCancelGameBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding:
              const EdgeInsets.only(top: 16, bottom: 8, left: 24, right: 24),
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
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.completer.complete(0);
                },
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 56,
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Edit Match Schedule',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.completer.complete(1);
                },
                child: Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: 56,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.isAccepted == false
                          ? 'Cancel Match Request'
                          : 'Cancel Match',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'General Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
