import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgeTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController textEditingController;
  const AgeTextField({
    super.key,
    required this.hintText,
    required this.textEditingController,
  });

  @override
  State<AgeTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<AgeTextField> {
  var isFocussed = false;
  // String _selectedDate = '';

  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = ''; // Initialize with an empty string
  }

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
          child: TextField(
            controller: widget.textEditingController,
            keyboardType: TextInputType.datetime,
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
              _DateInputFormatter(),
            ],
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
              setState(() {
                isFocussed = false;
              });
            },
            onTap: () {
              isFocussed = true;
            },
            maxLines: 1,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Space Mono',
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0x40FFFFFF),
                fontSize: 18,
                fontFamily: 'Space Grotesk',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final cleanText = newValue.text.replaceAll(RegExp(r'[^\w\s]+'), '');
    if (cleanText.length <= 10) {
      final formattedText = _formatDate(cleanText);

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    }
    return oldValue;
  }

  String _formatDate(String input) {
    if (input.length <= 2) {
      return input; // Handles "DD" format
    } else if (input.length <= 4) {
      return '${input.substring(0, 2)}/${input.substring(2)}'; // Handles "DD/MM" format
    } else {
      return '${input.substring(0, 2)}/${input.substring(2, 4)}/${input.substring(4, min(8, input.length))}'; // Handles "DD/MM/YYYY" format
    }
  }
}
