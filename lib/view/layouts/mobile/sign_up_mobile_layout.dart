import "dart:io";

import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/containers/form_page_container.dart';
import 'package:vaea_mobile/view/widgets/forms/registration_form.dart';
import 'package:vaea_mobile/view/widgets/forms/sign_up_otp_form.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/gender.dart';

/// It handles the ui appearance and user interaction for SignUpScreen.
class SignUpMobileLayout extends StatefulWidget {

  String? Function(String? input) validateFirstName;
  String? Function(String? input) validateLastName;
  String? Function(Gender? input) validateGender;
  String? Function(File? input) validateProfileImage;
  String? Function(String? input) validateIdIqamaNumber;
  Future<String?> Function(String? input) validateEmailAddress;
  String? Function(String? input) validatePassword;
  String? Function(String? passwordInput, String? confirmPasswordInput) validateConfirmPassword;
  void Function({required String firstName, required String lastName, required Gender gender,
  required File? profileImage, required String idIqamaNumber, required String emailAddress,
  required String password}) handleSubmitRegistrationForm;
  Future<String?> Function(String? input) validateOTPCode;
  /// It handles the event of clicking verify to finalizes the registration
  Future<bool> Function() handleFinalSubmit;

  SignUpMobileLayout({
    super.key,
    required this.validateFirstName,
    required this.validateLastName,
    required this.validateGender,
    required this.validateProfileImage,
    required this.validateIdIqamaNumber,
    required this.validateEmailAddress,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.handleSubmitRegistrationForm,
    required this.validateOTPCode,
    required this.handleFinalSubmit
  });


  @override
  State<StatefulWidget> createState() => _SignUpMobileLayoutState();
}

class _SignUpMobileLayoutState extends State<SignUpMobileLayout> {

  late Breakpoint breakpoint;
  final coastController = CoastController(initialPage: 0);


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        breakpoint = Breakpoint.fromConstraints(constraints);

        return Scaffold(
          body: Coast(
            controller: coastController,
            physics: const NeverScrollableScrollPhysics(),
            beaches: [
              Beach(builder: (context) => buildRegistrationPage(context, constraints)),
              Beach(builder: (context) => buildVerificationPage(context, constraints))
            ],
            observers: [
              CrabController(),
            ],
          ),
        );
      },
    );
  }


  /// It builds the first PageView for filling registration info
  Widget buildRegistrationPage(BuildContext context, BoxConstraints constraints) {
    return FormPageContainer(
      breakpoint: breakpoint,
      layoutBoxConstrains: constraints,
      pageTitle: AppLocalizations.of(context)!.registration,
      pageForm: RegistrationForm(
        breakpoint: breakpoint,
        layoutConstraints: constraints,
        validateFirstName: widget.validateFirstName,
        validateLastName: widget.validateLastName,
        validateGender: widget.validateGender,
        validateProfileImage: widget.validateProfileImage,
        validateIDIqamaNumber: widget.validateIdIqamaNumber,
        validateEmailAddress: widget.validateEmailAddress,
        validatePassword: widget.validatePassword,
        validateConfirmPassword: widget.validateConfirmPassword,
        handleSubmitRegistrationForm: handleSubmitRegistrationForm
      ),
    );
  }
  
  
  /// It builds the second PageView for filling the otp code
  Widget buildVerificationPage(BuildContext context, BoxConstraints constraints) {
    return FormPageContainer(
      breakpoint: breakpoint,
      layoutBoxConstrains: constraints,
      pageTitle: AppLocalizations.of(context)!.verification,
      pageForm: SignUpOTPForm(
        breakpoint: breakpoint,
        layoutConstraints: constraints,
        validateOTP: widget.validateOTPCode,
        handleSubmitOTP: handleSubmitOTPForm,
        handleClickBack: handleClickBack,
      ),
    );
  }


  /// It handles the event of clicking sign up by saving input and switching
  /// the pageview to SignUpOTPForm
  void handleSubmitRegistrationForm({required String firstName, required String lastName, required Gender gender,
      required File? profileImage, required String idIqamaNumber, required String emailAddress,
      required String password}) {

    widget.handleSubmitRegistrationForm(
      firstName: firstName,
      lastName: lastName,
      gender: gender,
      profileImage: profileImage,
      idIqamaNumber: idIqamaNumber,
      emailAddress: emailAddress,
      password: password
    );

    coastController.animateTo(beach: 1, duration: const Duration(milliseconds: 400));
  }


  /// It handles clicking back button to take the user back to the registration page.
  void handleClickBack() {
    coastController.animateTo(beach: 0, duration: const Duration(milliseconds: 400));
  }

  /// It handles the event of clicking done in the otp form to submit the input
  /// to screen for finalizing the registration.
  Future<bool> handleSubmitOTPForm(String otpCode) async {
    bool wasSuccess = await widget.handleFinalSubmit();

    return wasSuccess;
  }

}