import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key, required this.textEditingController});
  final TextEditingController textEditingController;

  @override
  State<PhoneNumber> createState() => _PhoneNumber();
}

class _PhoneNumber extends State<PhoneNumber> {
  var isFocussed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 44,
          padding: const EdgeInsets.only(
            top: 8,
            left: 12,
            right: 12,
            bottom: 8,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            border: Border(
              bottom: BorderSide(
                  width: isFocussed ? 2 : 1,
                  color: isFocussed
                      ? const Color(0xFFFFFFFF)
                      : const Color(0xFF333333)),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '+91',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Space Mono',
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(width: 16),
              Flexible(
                child: TextField(
                  onTapOutside: (event) {
                    setState(() {
                      isFocussed = false;
                    });
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  onTap: () {
                    setState(() {
                      isFocussed = true;
                    });
                  },
                  maxLines: 1,
                  // textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'Space Mono',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                    border: InputBorder.none,
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: Color(0x40FFFFFF),
                      fontSize: 18,
                      fontFamily: 'Space Grotesk',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  controller: widget.textEditingController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
