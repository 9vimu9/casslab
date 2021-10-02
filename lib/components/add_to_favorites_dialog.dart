import 'package:casslab/components/rounded_button.dart';
import 'package:casslab/components/rounded_input_field.dart';
import 'package:casslab/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class AddToFavoritesDialog {
  final String? initialValue;
  final BuildContext context;
  final GlobalKey<FormBuilderState> formKey;
  final void Function()? onSave;
  final void Function()? onCancel;

  const AddToFavoritesDialog(
    this.initialValue,
    this.context,
    this.formKey,
    this.onSave,
    this.onCancel,
  );

  Future<dynamic> displayAddToFavoritesDialog( ) {
    return showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: FormBuilder(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AlertDialog(
                contentPadding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 0, top: 10),
                actionsPadding:
                const EdgeInsets.only(left: 10, right: 10, top: 0),
                title: const Text('Add to Favorites'),
                content: RoundedInputField(
                  name: 'description_field',
                  minLines: 5,
                  hintText: "add a short description...",
                  onChanged: (value) {},
                  validator: FormBuilderValidators.compose([]),
                  initialValue: initialValue,
                ),
                actions: <Widget>[
                  RoundedButton(
                    color: kPrimaryColor,
                    text: 'SAVE',
                    press: onSave,
                  ),
                  RoundedButton(
                    color: kPrimaryCancelColor,
                    press: onCancel,
                    text: 'CANCEL',
                  ),
                ],
              ),
            ),
          );
        });
  }


}
