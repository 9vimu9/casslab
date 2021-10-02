import 'package:casslab/components/text_field_container.dart';
import 'package:casslab/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String name;
  final IconData? icon;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String> validator;
  final int? minLines;
  final int? maxLines;

  const RoundedInputField({
    Key? key,
    required this.name,
    required this.hintText,
    this.icon,
    required this.onChanged,
    required this.validator,
    this.minLines,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FormBuilderTextField(
        name: name,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          icon: icon == null
              ? null
              : Icon(
                  icon,
                  color: kPrimaryColor,
                ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
