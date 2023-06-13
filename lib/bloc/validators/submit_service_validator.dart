
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// It is used to validate the user input in SubmitServiceScreen
class SubmitServiceValidator {

  BuildContext context;

  SubmitServiceValidator({required this.context});

  /// It validates the date input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validateDate(DateTime? input) {
    if (input == null) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else {
      return null;
    }
  }


  /// It validates the dropdown field input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validateDropdownField(dynamic input) {
    if (input == null) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else {
      return null;
    }
  }


  /// It validates the description input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validateDescription(String? input) {
    if (input == null || input.replaceAll(" ", "").length == 0) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else {
      return null;
    }
  }


  /// It validates the notes input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validateNotes(String? input) {
    return null; // It is an optional field that the user can input anything.
  }
}