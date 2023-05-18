
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';
import 'package:vaea_mobile/view/widgets/buttons/secondary_button.dart';
import 'package:vaea_mobile/view/widgets/fields/otp_field.dart';

/// It builds, validates, and manages the verification form in SignUpMobileLayout.
class SignUpOTPForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  Future<String?> Function(String? input) validateOTP;
  Future<bool> Function(String otpCode) handleSubmitOTP;
  void Function() handleClickBack;

  SignUpOTPForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validateOTP,
    required this.handleSubmitOTP,
    required this.handleClickBack
  });

  @override
  State<SignUpOTPForm> createState() => _SignUpOTPFormState();
}

class _SignUpOTPFormState extends State<SignUpOTPForm> {

  TextEditingController otpCodeController = TextEditingController();
  String? otpCodeErrorMsg;

  // dimensions
  late double fieldsSpacer;
  late double fieldsBtnSpacer;
  late double btnWidth;


  @override
  void initState() {
    super.initState();

    setupDimensions();
  }


  /// It is a helper method to initState. It setups the dimensions in the form.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = widget.layoutConstraints.maxHeight * 0.075;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = widget.layoutConstraints.maxHeight * 0.075;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = widget.layoutConstraints.maxHeight * 0.075;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: widget.layoutConstraints.maxWidth * 0.92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildOtpField(),
          SizedBox(height: fieldsSpacer),
          buildInstructionsText(),
          SizedBox(height: fieldsBtnSpacer),
          buildActionBtns()
        ],
      ),
    );
  }


  /// It builds the otp field
  Widget buildOtpField() {
    return VAEAOTPField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: otpCodeController,
      handleOnSubmitted: handleClickDone,
      errorMsg: otpCodeErrorMsg,
    );
  }


  /// It builds the text instruction of inputting otp code
  Widget buildInstructionsText() {
    return Text(
      AppLocalizations.of(context)!.registrationOTPInstructions,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
        fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
        color: Theme.of(context).colorScheme.outlineVariant
      ),
    );
  }


  /// It builds verify button and back button
  Widget buildActionBtns() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SecondaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: widget.handleClickBack,
          buttonText: AppLocalizations.of(context)!.back,
          width: btnWidth,
        ),
        PrimaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: () => handleClickDone(otpCodeController.text),
          buttonText: AppLocalizations.of(context)!.verify,
          width: btnWidth,
        )
      ],
    );
  }

  /// It handles the event of clicking done on the user keyboard. It validates
  /// and submits the input.
  void handleClickDone(String? input) async {
    // validate
    debugPrint("in click 1");
    String? errorMsg = await widget.validateOTP(input);
    setState(() {
      otpCodeErrorMsg = errorMsg;
    });
    debugPrint("in click 1 $errorMsg");
    // submit if valid
    if(otpCodeErrorMsg == null) {
      widget.handleSubmitOTP(input!);
    }
  }


}