import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPTextField extends StatefulWidget {
  const OTPTextField({super.key});

  @override
  State<OTPTextField> createState() => _OTPTextField();
}

class _OTPTextField extends State<OTPTextField> {
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
            bottom: 12,
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
          child: Flexible(
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
              textAlignVertical: TextAlignVertical.center,
              textAlign: TextAlign.center,
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
                hintText: '0000',
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
            ),
          ),
        ),
      ],
    );
  }
}
