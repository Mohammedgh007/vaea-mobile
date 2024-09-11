
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../../buttons/primary_button.dart';
import '../../buttons/secondary_button.dart';
import '../../fields/text_field.dart';

/// It builds, validates, and manages the third form of reset password stepper.
class PasswordResetPassForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  String? Function(String? input) validatePassword;
  String? Function( String? passwordInput, String? confirmPasswordInput) validateConfirmPassword;
  Future<bool> Function(String oldPassword, String newPassword) submitResetPassword;
  void Function() handleClickPrevious;

  PasswordResetPassForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.submitResetPassword,
    required this.handleClickPrevious
  });

  @override
  State<PasswordResetPassForm> createState() => _PasswordResetPassFormState();
}

class _PasswordResetPassFormState extends State<PasswordResetPassForm> {

  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmNewPassController = TextEditingController();
  String? oldPassErrorMsg;
  String? newPassErrorMsg;
  String? confirmNewPassErrorMsg;

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
          SizedBox(height: rowsSpacer * 2),
          buildActionBtns()
        ],
      ),
    );
  }

  /// It builds the fields rows
  Widget buildFieldRows() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VAEATextField(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          controller: oldPassController,
          labelStr: AppLocalizations.of(context)!.oldPasswordLabelField,
          hintStr: "******",
          textInputAction: TextInputAction.next,
          errorMsg: oldPassErrorMsg,
          isTextObscure: true
        ),
        SizedBox(height: rowsSpacer),
        VAEATextField(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          controller: newPassController,
          labelStr: AppLocalizations.of(context)!.newPasswordLabelField,
          hintStr: "******",
          textInputAction: TextInputAction.next,
          errorMsg: newPassErrorMsg,
          isTextObscure: true
        ),
        SizedBox(height: rowsSpacer),
        VAEATextField(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          controller: confirmNewPassController,
          labelStr: AppLocalizations.of(context)!.confirmPasswordFieldLabel,
          hintStr: "******",
          textInputAction: TextInputAction.done,
          handleOnSubmitted: (_) => handleSubmit(),
          errorMsg: confirmNewPassErrorMsg,
          isTextObscure: true
        ),
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
  void handleSubmit() {
    bool areValid = validateInputs();

    if (areValid) {
      widget.submitResetPassword(oldPassController.text, newPassController.text);
    }
  }


  /// It is a helper method for handleSubmit. It validates the inputs.
  bool validateInputs() {
    // validate the old password input
    String? oldPassErrorMsg = widget.validatePassword(oldPassController.text);
    setState(() {
      oldPassErrorMsg = oldPassErrorMsg;
    });

    // validate the old password input
    String? newPassErrorMsg = widget.validatePassword(newPassController.text);
    setState(() {
      newPassErrorMsg = newPassErrorMsg;
    });

    // validate the old password input
    String? confirmPassErrorMsg = widget.validateConfirmPassword(newPassController.text, confirmNewPassController.text);
    setState(() {
      confirmNewPassErrorMsg = confirmPassErrorMsg;
    });

    return (oldPassErrorMsg == null) && (newPassErrorMsg == null) && (confirmPassErrorMsg == null);
  }

}