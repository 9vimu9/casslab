import 'package:casslab/helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:casslab/components/text_field_container.dart';
import 'package:casslab/constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class RoundedPasswordField extends StatefulWidget {

  final String name;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String> validator;
  bool obscureText = true;

  RoundedPasswordField({
    required this.name,
    required this.onChanged,
    required this.validator,
    Key? key,
  }) : super(key: key);

  @override
  RoundedPasswordFieldState createState() {
    return RoundedPasswordFieldState(
      name: name, onChanged: onChanged, validator: validator);
  }
}


class RoundedPasswordFieldState extends State<RoundedPasswordField> {

  final String name;
  final ValueChanged<String?>? onChanged;
  final FormFieldValidator<String> validator;
  bool _obscureText = true;

  RoundedPasswordFieldState({
    required this.name,
    required this.onChanged,
    required this.validator,
  });



  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: FormBuilderTextField(
        name: name,
        validator: validator,
        obscureText: _obscureText,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "Password",
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            color: kPrimaryColor,
            icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off), onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
