
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/vaea_ui/vaea_horizontal_stepper.dart';

/// It handles the ui appearance and user interaction for ResetPasswordScreen.
class ResetPasswordMobileLayout extends StatefulWidget {

  Future<String?> Function(String? input) validateEmailAddress;
  Future<bool> Function(String emailAddress) submitEmailAddress;
  Future<String?> Function(String? input, String emailAddress) validateOTP;
  String? Function(String? input) validatePassword;
  String? Function( String? passwordInput, String? confirmPasswordInput) validateConfirmPassword;
  Future<bool> Function(String emailAddress, String oldPassword, String newPassword) submitResetPassword;

  ResetPasswordMobileLayout({
    super.key,
    required this.validateEmailAddress,
    required this.submitEmailAddress,
    required this.validateOTP,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.submitResetPassword
  });


  @override
  State<ResetPasswordMobileLayout> createState() => _ResetPasswordMobileLayoutState();
}

class _ResetPasswordMobileLayoutState extends State<ResetPasswordMobileLayout> {

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
          AppLocalizations.of(context)!.leasePeriod,
          AppLocalizations.of(context)!.confirmation,
          AppLocalizations.of(context)!.payment
        ],
        currStep: currStep
    );
  }


  /// It builds the stepper body content.
  Widget buildNthStepContent() {
    switch(currStep) {
      case 0: // Lease period
        return SizedBox();
      case 1:
        return SizedBox();
      case 2:
        return SizedBox();
      default: // confirming the booking success
        return SizedBox();
    }
  }


  /// It handles the event of clicking cancel.
  void handleClickCancel() {
    Navigator.of(context).pop();
  }

  /// It handles the event of clicking previous
  void handleClickPrevious() {
    setState(() {
      currStep = currStep - 1;
    });
  }

}