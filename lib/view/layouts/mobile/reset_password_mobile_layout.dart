
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/containers/confirmation_message_container.dart';
import 'package:vaea_mobile/view/widgets/forms/reset_password_forms/email_address_reset_pass_form.dart';
import 'package:vaea_mobile/view/widgets/forms/reset_password_forms/otp_reset_pass_form.dart';
import 'package:vaea_mobile/view/widgets/forms/reset_password_forms/password_reset_pass_form.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/vaea_ui/vaea_horizontal_stepper.dart';

/// It handles the ui appearance and user interaction for ResetPasswordScreen.
class ResetPasswordMobileLayout extends StatefulWidget {

  String? prefilledEmailAddress;
  Future<String?> Function(String? input) validateEmailAddress;
  Future<bool> Function(String emailAddress) submitEmailAddress;
  Future<String?> Function(String? input, String emailAddress) validateOTP;
  String? Function(String? input) validatePassword;
  String? Function( String? passwordInput, String? confirmPasswordInput) validateConfirmPassword;
  Future<bool> Function(String emailAddress, String oldPassword, String newPassword) submitResetPassword;
  void Function() handleClickFinish;

  ResetPasswordMobileLayout({
    super.key,
    this.prefilledEmailAddress,
    required this.validateEmailAddress,
    required this.submitEmailAddress,
    required this.validateOTP,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.submitResetPassword,
    required this.handleClickFinish
  });


  @override
  State<ResetPasswordMobileLayout> createState() => _ResetPasswordMobileLayoutState();
}

class _ResetPasswordMobileLayoutState extends State<ResetPasswordMobileLayout> {

  // inputs
  String inputtedEmailAddress = "";

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;
  int currStep = 0;
  bool isLoading = false;

  // dimensions
  late double btnWidth;
  late double sectionsSpacer;
  late double titleSpacer;
  late double bodyTextSpacer;

  /// It is a helper method for build(). It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.44;
      sectionsSpacer = layoutConstraints.maxHeight * 0.038;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.44;
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else {
      btnWidth = layoutConstraints.maxWidth * 0.44;
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      breakpoint = Breakpoint.fromConstraints(constraints);
      layoutConstraints = constraints;
      setupDimensions();

      return Scaffold(
        appBar: AdaptiveTopAppBar(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            previousPageTitle: AppLocalizations.of(context)!.profile,
            currPageTitle: AppLocalizations.of(context)!.resetPasswordScreen
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepper(),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: layoutConstraints.maxWidth * 0.04, vertical: layoutConstraints.maxHeight * 0.03),
                  child: buildNthStepContent(),
                )
            ),
          ],
        ),
      );
    }
    );
  }


  /// It builds the stepper section as a header.
  Widget buildStepper() {
    return (currStep == 3) ? SizedBox() : VAEAStepper(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        stepsNames: [
          AppLocalizations.of(context)!.emailAddressStep,
          AppLocalizations.of(context)!.verification,
          AppLocalizations.of(context)!.passwordResetStep
        ],
        currStep: currStep
    );
  }


  /// It builds the stepper body content.
  Widget buildNthStepContent() {
    switch(currStep) {
      case 0: // Lease period
        return EmailAddressResetPassForm(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          prefilledEmailAddress: (inputtedEmailAddress.isNotEmpty) ? inputtedEmailAddress : widget.prefilledEmailAddress,
          validateEmailAddress: widget.validateEmailAddress,
          handleSubmitEmailAddress: handleSubmitEmailAddressForm,
          handleClickCancel: handleClickCancel
        );
      case 1:
        return OTPResetPassForm(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          validateOTP: (String? otp) => widget.validateOTP(otp, inputtedEmailAddress),
          handleSubmitOTP: handleSubmitOTP,
          handleClickPrevious: handleClickPreviousOTP
        );
      case 2:
        return PasswordResetPassForm(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          validatePassword: widget.validatePassword,
          validateConfirmPassword: widget.validateConfirmPassword,
          submitResetPassword: submitResetPassword,
          handleClickPrevious: handleClickPreviousPassword
        );
      default: // confirming the booking success
        return ConfirmationMessageContainer(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          titleMessage: AppLocalizations.of(context)!.resetPasswordConfirmTitle,
          subTitleMessage: "sssssssss sssssss sssss ss\n aaaaaa",
          actionButtonTitle: AppLocalizations.of(context)!.finish,
          handleClickActionButton: widget.handleClickFinish
        );
    }
  }

  /// It handles submitting the email address form
  Future<bool> handleSubmitEmailAddressForm(String emailAddress) async {
    bool wasSuccess = await widget.submitEmailAddress(emailAddress);
    if (wasSuccess) {
      setState(() {
        inputtedEmailAddress = emailAddress;
        currStep = 1;
      });
    }

    return wasSuccess;
  }


  /// It handles submitting the password form
  Future<bool> submitResetPassword(String oldPassword, String newPassword) async {
    bool wasSuccess = await widget.submitResetPassword(inputtedEmailAddress, oldPassword, newPassword);
    if (wasSuccess) {
      setState(() {
        currStep = 3;
      });
    }

    return wasSuccess;
  }


  /// It handles submitting the otp code assuming it is validated.
  void handleSubmitOTP() {
    setState(() {
      currStep = 2;
    });
  }

  /// It handles the event of clicking cancel.
  void handleClickCancel() {
    Navigator.of(context).pop();
  }

  /// It handles the event of clicking previous on otp form
  void handleClickPreviousOTP() {
    setState(() {
      currStep = currStep - 1;
    });
  }


  /// It handles the event of clicking previous on reset password form
  void handleClickPreviousPassword() {

  }

}