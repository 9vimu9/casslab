import 'package:casslab/components/text_field_container.dart';
import 'package:casslab/constants.dart';
import 'package:flutter/material.dart';

class RoundedMultilineInputField extends StatelessWidget {
  final String hintText;
  final int minLines;
  final int? maxLines;
  final ValueChanged<String> onChanged;

  const RoundedMultilineInputField({
    Key? key,
    required this.minLines,
    this.maxLines,
    required this.hintText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.multiline,
        minLines: minLines,
        //Normal textInputField will be displayed
        maxLines: maxLines,
        // when user presses enter it will adapt to it
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
