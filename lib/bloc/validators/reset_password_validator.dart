import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/dto/verify_otp_dto.dart';
import '../../data/repo/verify_reset_password_repo.dart';
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/unknown_except.dart';

/// It is used to validate the user input in ResetPasswordScreen
class ResetPasswordValidator {

  static const String _emailRegExpStr = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
  static final RegExp _emailRegExp = RegExp(_emailRegExpStr);
  static final RegExp _otpRegExp = RegExp(r'^[0-9]{5}$');

  VerifyResetPasswordRepo _repo = VerifyResetPasswordRepo();
  BuildContext context;

  ResetPasswordValidator({required this.context});


  /// It validates the email address input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  Future<String?> validateEmailAddress(String? input) async {
    if (input == null || input.replaceAll(" ", "").length == 0) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else if (!_emailRegExp.hasMatch(input)) {
      return AppLocalizations.of(context)!.invalidEmailErrorMsg;
    } else if ( !(await _repo.verifyEmail(input)) ) {
      return AppLocalizations.of(context)!.thereNoAccountWithThisEmail;
    } else {
      return null;
    }
  }

  /// It validates the otp code input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  Future<String?> validateOTP(String? input, String emailAddress) async {
    try {
      VerifyOTPDto requestDto = VerifyOTPDto(emailAddress: emailAddress, otpCode: input!);
      if (input == null || input.replaceAll(" ", "").length == 0) {
        return AppLocalizations.of(context)!.requiredFieldErrorMsg;
      } else if (!_otpRegExp.hasMatch(input)) {
        return AppLocalizations.of(context)!.nonNumericValuesNotAllowedError;
      } else if ((!(await _repo.verifyOTP(requestDto)))) {
        return AppLocalizations.of(context)!.provideCorrectOTPErrorMsg;
      } else {
        debugPrint("innnnnnn VALIDATOR");
        return null;
      }
    } on InternetConnectionException catch (e) {
      rethrow;
    } on UnknownException catch (e) {
      rethrow;
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

  /// It validates the password input.
  /// @return either null if the input is valid or a string that represents
  /// the error message.
  String? validateConfirmPassword( String? passwordInput, String? confirmPasswordInput) {
    if (confirmPasswordInput == null || confirmPasswordInput.replaceAll(" ", "").length == 0) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else if (confirmPasswordInput != passwordInput) {
      return AppLocalizations.of(context)!.passwordsmustmatchErrormsg;
    } else {
      return null;
    }
  }

}
