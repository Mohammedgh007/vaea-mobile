

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/fields/otp_field.dart';

import '../../buttons/primary_button.dart';
import '../../buttons/secondary_button.dart';


/// It builds, validates, and manages the second form of reset password stepper.
class OTPResetPassForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  Future<String?> Function(String? input) validateOTP;
  void Function() handleSubmitOTP;
  void Function() handleClickPrevious;

  OTPResetPassForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validateOTP,
    required this.handleSubmitOTP,
    required this.handleClickPrevious
  });

  @override
  State<OTPResetPassForm> createState() => _OTPResetPassFormState();
}

class _OTPResetPassFormState extends State<OTPResetPassForm> {

  TextEditingController otpController = TextEditingController();
  String? otpErrorMsg;

  // dimensions
  late double rowsSpacer;
  late double btnWidth;


  @override
  void initState() {
    super.initState();

    setupDimensions();
  }


  /// It is a helper method to initState. It setups the dimensions in the form.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      rowsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      rowsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else {
      rowsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.layoutConstraints.maxWidth * 0.92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildFieldRows(),
          buildActionBtns()
        ],
      ),
    );
  }


  /// It builds the rows that contains the instruction and the field.
  Widget buildFieldRows() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.resetPasswordStep2Instruction,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
              color: Theme.of(context).colorScheme.outlineVariant
          ),
        ),
        SizedBox(height: rowsSpacer),
        VAEAOTPField(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          controller: otpController,
          handleOnSubmitted: (_) => handleSubmit(),
          errorMsg: otpErrorMsg,
        )
      ],
    );
  }


  /// It builds the action button rows
  Widget buildActionBtns() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SecondaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: widget.handleClickPrevious,
          buttonText: AppLocalizations.of(context)!.previous,
          width: btnWidth,
        ),
        PrimaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: handleSubmit,
          buttonText: AppLocalizations.of(context)!.next,
          width: btnWidth,
        )
      ],
    );
  }


  /// It handles the event of clicking next by validating the input then submitting
  /// the form input.
  void handleSubmit() async {
    // validate the input
    String? errorMsg = await widget.validateOTP(otpController.text);
    setState(() {
      otpErrorMsg = errorMsg;
    });

    // submit the input
    if (otpErrorMsg == null) {
      widget.handleSubmitOTP();
    }
  }

}