import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/profile_provider.dart';
import 'package:vaea_mobile/bloc/providers/user_settings_provider.dart';
import 'package:vaea_mobile/bloc/validators/sign_up_validator.dart';
import 'package:vaea_mobile/data/dto/request_email_otp_dto.dart';
import 'package:vaea_mobile/data/dto/save_user_profile_dto.dart';
import 'package:vaea_mobile/data/dto/sign_up_dto.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/sign_up_mobile_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/enums/gender.dart';

/// This class handles the view and its interactions with the rest of app
/// for sign in screen.
class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  late final ProfileProvider profileProvider;
  late final UserSettingsProvider settingsProvider;

  late SignUpValidator validator;

  // registration form inputs
  late String submittedFirstName;
  late String submittedLastName;
  late Gender submittedGender;
  late File? submittedProfileImage;
  late String submittedIdIqamaNumber;
  late String submittedEmailAddress;
  late String submittedPassword;


  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    settingsProvider = Provider.of<UserSettingsProvider>(context, listen: false);
    validator = SignUpValidator(context: context);
  }

  @override
  Widget build(BuildContext context) {

    return SignUpMobileLayout(
      validateFirstName: validator.validateFirstName,
      validateLastName: validator.validateLastName,
      validateGender: validator.validateGender,
      validateProfileImage: validator.validateProfileImage,
      validateIdIqamaNumber: validator.validateIdIqamaNumber,
      validateEmailAddress: validator.validateEmailAddress,
      validatePassword: validator.validatePassword,
      validateConfirmPassword: validator.validateConfirmPassword,
      validateOTPCode: (String? inputOTP) => validator.validateOTP(inputOTP, submittedEmailAddress),
      handleSubmitRegistrationForm: handleSubmitRegistrationForm,
      handleFinalSubmit: handleFinalSubmit,
    );
  }


  /// It handles the event of submitting the registration form by storing its inputs
  /// to e sent to backend and then request to send otp.
  void handleSubmitRegistrationForm({required String firstName, required String lastName, required Gender gender,
    required File? profileImage, required String idIqamaNumber, required String emailAddress,
    required String password}) {

    // save input
    submittedFirstName = firstName;
    submittedLastName = lastName;
    submittedGender = gender;
    submittedProfileImage = profileImage;
    submittedIdIqamaNumber = idIqamaNumber;
    submittedEmailAddress = emailAddress;
    submittedPassword = password;

    // request to send otp
    RequestEmailOTPDto requestDto = RequestEmailOTPDto(
      emailAddress: emailAddress,
      requestType: "REGISTRATION",
      languageIso: AppLocalizations.of(context)!.localeName
    );
    profileProvider.requestEmailOTP(requestDto);
  }


  /// It handles submitting all the inputs to finalizes the registration.
  Future<bool> handleFinalSubmit() async {
    SignUpDto signUpDto = SignUpDto(
      firstName: submittedFirstName,
      lastName: submittedLastName,
      gender: submittedGender,
      profileImage: submittedProfileImage,
      idIqamaNumber: submittedIdIqamaNumber,
      emailAddress: submittedEmailAddress,
      password: submittedPassword,
      isoLanguage: AppLocalizations.of(context)!.localeName
    );

    SaveUserProfileDto saveUserProfileDto = SaveUserProfileDto(
      firstName: submittedFirstName,
      lastName: submittedLastName,
      emailAddress: submittedEmailAddress,
      profileImageUrl: "",  // It will be assigned in repo
      userLanguage: AppLocalizations.of(context)!.localeName
    );

    profileProvider.signUpTenant(signUpDto, saveUserProfileDto);

    settingsProvider.changeUserLanguage(AppLocalizations.of(context)!.localeName);

    if (profileProvider.targetScreenAfterSignIn == null) {
      Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.home));
    } else {
      Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(profileProvider.targetScreenAfterSignIn!));
      profileProvider.targetScreenAfterSignIn = null;
    }
    return true;
  }

}