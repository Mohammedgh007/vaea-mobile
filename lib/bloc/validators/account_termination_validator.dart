
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/repo/verify_account_termination_repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/dto/verify_otp_dto.dart';
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/unknown_except.dart';

/// It is used to validate the inputs in AccountTerminationScreen
class AccountTerminationValidator {

  static final RegExp _otpRegExp = RegExp(r'^[0-9]{5}$');

  BuildContext context;
  VerifyAccountTerminationRepo _repo = VerifyAccountTerminationRepo();

  AccountTerminationValidator({required this.context});


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
      } else if(( !(await _repo.verifyOTP(requestDto))) ) {
        return AppLocalizations.of(context)!.provideCorrectOTPErrorMsg;
      } else { debugPrint("innnnnnn VALIDATOR");
      return null;
      }
    } on InternetConnectionException catch(e) {
      rethrow;
    } on UnknownException catch(e) {
      rethrow;
    }
  }

}
