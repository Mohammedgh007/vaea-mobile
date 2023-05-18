import "dart:io";

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/dto/verify_otp_dto.dart';

import '../../data/enums/gender.dart';
import '../../data/repo/verify_sign_up_repo.dart';
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/unknown_except.dart';

/// It is used to validate the user input in SignUpScreen.
class SignUpValidator {

   static const String _emailRegExpStr = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
   static final RegExp _emailRegExp = RegExp(_emailRegExpStr);
   static const String _nameRegExpStr = r"^[\p{L} ,.'-]*$";
   static final RegExp _namesRegExp = RegExp(_nameRegExpStr, unicode: true, caseSensitive: false, dotAll: true);
   static final RegExp _idIqamaRegExp = RegExp(r'^[0-9]{10}$');
   static final RegExp _otpRegExp = RegExp(r'^[0-9]{5}$');

   BuildContext context;
   VerifySignUpRepo _repo = VerifySignUpRepo();

   SignUpValidator({required this.context});


   /// It validates the first name input.
   /// @return either null if the input is valid or a string that represents
   /// the error message.
   String? validateFirstName(String? input) {
      if (input == null || input.replaceAll(" ", "").length == 0) {
         return AppLocalizations.of(context)!.requiredFieldErrorMsg;
      } else if (!_namesRegExp.hasMatch(input)) {
         return AppLocalizations.of(context)!.invalidNameErrorMsg;
      } else {
         return null;
      }
   }

   /// It validates the last name input.
   /// @return either null if the input is valid or a string that represents
   /// the error message.
   String? validateLastName(String? input) {
      if (input == null || input.replaceAll(" ", "").length == 0) {
         return AppLocalizations.of(context)!.requiredFieldErrorMsg;
      } else if (!_namesRegExp.hasMatch(input)) {
         return AppLocalizations.of(context)!.invalidNameErrorMsg;
      } else {
         return null;
      }
   }


   /// It validates the gender input.
   /// @return either null if the input is valid or a string that represents
   /// the error message.
   String? validateGender(Gender? input) {
      if (input == null) {
         return AppLocalizations.of(context)!.requiredFieldErrorMsg;
      } else {
         return null;
      }
   }


   /// It validates the profile image input.
   /// @return either null if the input is valid or a string that represents
   /// the error message.
   String? validateProfileImage(File? input) {
      return null; // currently it does not require any validating
   }


   /// It validates the id/iqama input.
   /// @return either null if the input is valid or a string that represents
   /// the error message.
   String? validateIdIqamaNumber(String? input) {
      if (input == null || input.replaceAll(" ", "").length == 0) {
         return AppLocalizations.of(context)!.requiredFieldErrorMsg;
      } else if (!_idIqamaRegExp.hasMatch(input)) {
         return AppLocalizations.of(context)!.invalidIdIqamaNumberErrorMsg;
      } else {
         return null;
      }
   }

   /// It validates the email address input.
   /// @return either null if the input is valid or a string that represents
   /// the error message.
   /// @throws InternetConnectionException, UnknownException
   Future<String?> validateEmailAddress(String? input) async {
      try {
         if (input == null || input.replaceAll(" ", "").length == 0) {
            return AppLocalizations.of(context)!.requiredFieldErrorMsg;
         } else if (!_emailRegExp.hasMatch(input)) {
            return AppLocalizations.of(context)!.invalidEmailErrorMsg;
         } else if (! (await _repo.verifyEmail(input)) ) {
            return AppLocalizations.of(context)!.usedEmailErrorMsg;
         } else {
            return null;
         }
      } on InternetConnectionException catch(e) {
         rethrow;
      } on UnknownException catch(e) {
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
   String? validateConfirmPassword(String? passwordInput, String? confirmPasswordInput) {
      if (confirmPasswordInput == null || confirmPasswordInput.replaceAll(" ", "").length == 0) {
         return AppLocalizations.of(context)!.requiredFieldErrorMsg;
      } else if (confirmPasswordInput != passwordInput) {
         return AppLocalizations.of(context)!.passwordsmustmatchErrormsg;
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