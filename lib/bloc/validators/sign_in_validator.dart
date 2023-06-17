
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/repo/verify_reset_password_repo.dart';

import '../../data/dto/verify_otp_dto.dart';
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/unknown_except.dart';

/// It is used to validate the user input in SignInScreen.
class SignInValidator {

  static const String _emailRegExpStr = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  static final RegExp _emailRegExp = RegExp(_emailRegExpStr);

  BuildContext context;

  SignInValidator({required this.context});

  /// It validates the email address input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validateEmailAddress(String? input) {
    if (input == null || input.replaceAll(" ", "").length == 0) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else if (!_emailRegExp.hasMatch(input)) {
      return AppLocalizations.of(context)!.invalidEmailErrorMsg;
    } else {
    return null;
    }
  }


  /// It validates the password input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validatePassword(String? input) {
    if (input == null || input.replaceAll(" ", "").length == 0) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else {
      return null;
    }
  }

}