
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/fields/otp_field.dart';
import 'package:vaea_mobile/view/widgets/fields/text_field.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/vaea_ui/vaea_horizontal_stepper.dart';

/// It handles the ui interaction for AccountTerminationScreen
class AccountTerminationMobileLayout extends StatefulWidget {

  Future<String?> Function(String? input) validateOtp;
  void Function(String reason) handleSubmitReason;
  Future<bool> Function() handleTerminate;

  AccountTerminationMobileLayout({
    super.key,
    required this.validateOtp,
    required this.handleSubmitReason,
    required this.handleTerminate
  });


  @override
  State<AccountTerminationMobileLayout> createState() => _AccountTerminationMobileLayoutState();
}

class _AccountTerminationMobileLayoutState extends State<AccountTerminationMobileLayout> {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;
  int currStep = 0;
  bool isLoading = false;

  // dimensions
  late double btnWidth;

  // inputs
  TextEditingController reasonController = TextEditingController();
  String? reasonErrorMsg;
  FocusNode reasonFocus = FocusNode();
  TextEditingController otpController = TextEditingController();
  String? otpErrorMsg;
  bool hasVerifiedOtp = false;

  /// It is a helper method for build(). It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.44;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.44;
    } else {
      btnWidth = layoutConstraints.maxWidth * 0.44;
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
            currPageTitle: AppLocalizations.of(context)!.accountTerminationScreenTitle
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
            buildActionBtns(),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 10)
          ],
        ),
      );
    }
    );
  }

  /// It builds the stepper section as a header.
  Widget buildStepper() {
    return VAEAStepper(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        stepsNames: [
          AppLocalizations.of(context)!.reasonSectionTitle,
          AppLocalizations.of(context)!.otpVerificationSection,
          AppLocalizations.of(context)!.confirmation
        ],
        currStep: currStep
    );
  }

  /// It builds the stepper body content.
  Widget buildNthStepContent() {
    switch(currStep) {
      case 0: // Lease period
        return buildReasonStep();
      case 1:
        return buildVerificationStep();
      default: //case 2:
        return buildConfirmationStep();
    }
  }


  /// It builds the first step that includes a text and a text field
  Widget buildReasonStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.accountTerminationStep1Text, textAlign: TextAlign.center),
          SizedBox(height: 20),
          VAEATextField(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            controller: reasonController,
            errorMsg: reasonErrorMsg,
            labelStr: AppLocalizations.of(context)!.reason,
            hintStr: "",
            minLinesNum: 5,
            textInputAction: TextInputAction.newline,
            focus: reasonFocus,
            isTextObscure: false
          )
        ],
      ),
    );
  }


  /// It builds the step of verification
  Widget buildVerificationStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.accountTerminationStep2Text, textAlign: TextAlign.center),
          SizedBox(height: 20),
          VAEAOTPField(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            controller: otpController,
            errorMsg: otpErrorMsg,
            handleOnSubmitted: handleSubmitOtp
          )
        ],
      ),
    );
  }


  /// It builds the step of verification
  Widget buildConfirmationStep() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocalizations.of(context)!.accountTerminationStep3Text, textAlign: TextAlign.center),
          SizedBox(height: 20),

        ],
      ),
    );
  }


  /// It builds the bottom row of action buttons
  Widget buildActionBtns() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: layoutConstraints.maxWidth * 0.04),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SecondaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: handleClickCancel,
            buttonText: AppLocalizations.of(context)!.cancel,
            width: btnWidth,
          ),
          PrimaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: (currStep == 2)
                ? handleSubmit
                : handleClickNext,
            buttonText: (currStep == 2)
                ? AppLocalizations.of(context)!.deleteAccount
                : AppLocalizations.of(context)!.next,
            width: btnWidth,
          )
        ],
      ),
    );
  }


  /// It handles the event of clicking done on the user keyboard. It validates
  /// and submits the input.
  void handleSubmitOtp(String? input) async {
    // validate
    String? errorMsg = await widget.validateOtp(input);
    setState(() {
      otpErrorMsg = errorMsg;
      hasVerifiedOtp = true;
    });

    // submit if valid
    if(otpErrorMsg == null) {
      handleClickNext();
    }
  }


  /// It handles the event of clicking next.
  void handleClickNext() async {
    // validate that the inputs
    if (currStep == 0) {
      if (reasonController.text.isEmpty) {
        setState(() {
          reasonErrorMsg = AppLocalizations.of(context)!.requiredFieldErrorMsg;
        });
        reasonFocus.unfocus();
        return;
      } else {
        setState(() {
          reasonErrorMsg = null;
        });
        widget.handleSubmitReason(reasonController.text);
      }
    } else if (currStep == 1 && !hasVerifiedOtp) {
      String? errorMsg = await widget.validateOtp(otpController.text);
      if (errorMsg != null) {
        setState(() {
          otpErrorMsg = errorMsg;
        });
        return;
      } else {
        setState(() {
          otpErrorMsg = errorMsg;
        });
      }
    }

    // let the user progress
    setState(() {
      currStep += 1;
    });
  }


  /// It handles the event of submitting through clicking delete account.
  void handleSubmit() async {
    setState(() => isLoading = true);
    await widget.handleTerminate();
    setState(() => isLoading = false);

  }


  /// It handles the event of clicking cancel.
  void handleClickCancel() {
    Navigator.of(context).pop();
  }


}
