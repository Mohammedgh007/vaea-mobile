
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/fields/text_field.dart';

import '../../buttons/primary_button.dart';
import '../../buttons/secondary_button.dart';

/// It builds, validates, and manages the first form of reset password stepper.
class EmailAddressResetPassForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  String? prefilledEmailAddress;
  Future<String?> Function(String? input) validateEmailAddress;
  Future<bool> Function(String emailAddress) handleSubmitEmailAddress;
  void Function() handleClickCancel;

  EmailAddressResetPassForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.prefilledEmailAddress,
    required this.validateEmailAddress,
    required this.handleSubmitEmailAddress,
    required this.handleClickCancel
  });

  @override
  State<EmailAddressResetPassForm> createState() => _EmailAddressResetPassFormState();
}

class _EmailAddressResetPassFormState extends State<EmailAddressResetPassForm> {

  TextEditingController emailAddressController = TextEditingController();
  String? emailAddressErrorMsg;

  // dimensions
  late double rowsSpacer;
  late double btnWidth;


  @override
  void initState() {
    super.initState();

    emailAddressController.text = (widget.prefilledEmailAddress != null) ? widget.prefilledEmailAddress! : "";
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
          AppLocalizations.of(context)!.inputEmailAddressOfYourAccount,
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).colorScheme.outlineVariant
          ),
        ),
        SizedBox(height: rowsSpacer),
        VAEATextField(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          controller: emailAddressController,
          labelStr: AppLocalizations.of(context)!.emailAddressFieldLabel,
          hintStr: AppLocalizations.of(context)!.emailAddressFieldHint,
          textInputAction: TextInputAction.done,
          handleOnSubmitted: (_) => handleSubmit(),
          errorMsg: emailAddressErrorMsg,
          isTextObscure: false
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
          handleClick: widget.handleClickCancel,
          buttonText: AppLocalizations.of(context)!.cancel,
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
    String? errorMsg = await widget.validateEmailAddress(emailAddressController.text);
    setState(() {
      emailAddressErrorMsg = errorMsg;
    });

    // submit the input
    if (errorMsg == null) {
      widget.handleSubmitEmailAddress(emailAddressController.text);
    }
  }


}