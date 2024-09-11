

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/validators/reset_password_validator.dart';
import 'package:vaea_mobile/data/dto/request_email_otp_dto.dart';
import 'package:vaea_mobile/data/dto/reset_password_dto.dart';
import 'package:vaea_mobile/helpers/excpetions/internet_connection_except.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/reset_password_mobile_layout.dart';

import '../../bloc/providers/profile_provider.dart';

/// This class handles the view and its interactions with the rest of app
/// for Reset Password screen.
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});


  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  late final ProfileProvider profileProvider;
  late final ResetPasswordValidator validator;


  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    validator = ResetPasswordValidator(context: context);
  }

  @override
  Widget build(BuildContext context) {

    return ResetPasswordMobileLayout(
      prefilledEmailAddress: (profileProvider.profileModel != null) ? profileProvider.profileModel!.emailAddress : null,
      validateEmailAddress: validator.validateEmailAddress,
      submitEmailAddress: handleSubmitEmail,
      validateOTP: validator.validateOTP,
      validatePassword: validator.validatePassword,
      validateConfirmPassword: validator.validateConfirmPassword,
      submitResetPassword: handleSubmitResetPassword,
      handleClickFinish: handleClickFinish,
    );
  }


  /// It submits the otp request for the given email address
  Future<bool> handleSubmitEmail(String emailAddress) async {
    try {
      RequestEmailOTPDto requestDto = RequestEmailOTPDto(emailAddress: emailAddress, requestType: "RESET_PASSWORD", languageIso: "en");
      await profileProvider.requestEmailOTP(requestDto);
      return true;
    } on InternetConnectionException catch(e) {
      return false;
    }
  }


  /// It submits the request of the password reset
  Future<bool> handleSubmitResetPassword(String emailAddress, String oldPassword, String newPassword) async {
    try {
      ResetPasswordDto requestDto = ResetPasswordDto(emailAddress: emailAddress, oldPassword: oldPassword, newPassword: newPassword);
      await profileProvider.resetPassword(requestDto);
      return true;
    } on InternetConnectionException catch(e) {
      return false;
    }
  }


  /// It lets the user leaves the screen after successfully resetting the password.
  void handleClickFinish() {
    if (profileProvider.profileModel != null) {
      Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.profile));
    } else {
      Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.signIn));
    }

  }

}