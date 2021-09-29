import 'package:flutter/material.dart';
import 'package:casslab/components/text_field_container.dart';
import 'package:casslab/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final String name;
  final IconData icon;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String> validator;
  const RoundedInputField({
    Key? key,
    required this.name,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FormBuilderTextField(
        name: name,
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
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
