
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

/// It builds otp field using VAEA theme
class VAEAOTPField extends StatelessWidget {

  final Breakpoint breakpoint;
  final BoxConstraints layoutConstraints;
  TextEditingController controller;
  final FocusNode? focus;
  final bool? isDisabled;
  /// If it is null, then the field is not in error state
  final String? errorMsg;
  final void Function(String? input) handleOnSubmitted;

  // dimensions
  late double borderRadius;
  late double borderWidth;
  late double singleFieldWidth;
  late double wholeFieldsWidth;

  VAEAOTPField({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.controller,
    this.isDisabled,
    this.focus,
    this.errorMsg,
    required this.handleOnSubmitted
  }){
    setupDimensions();
  }

  /// It is a helper method for the constructor. It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      borderRadius = layoutConstraints.maxWidth * 0.0368;
      borderWidth = layoutConstraints.maxWidth * 0.005;
      singleFieldWidth = layoutConstraints.maxWidth * 0.125;
      wholeFieldsWidth = layoutConstraints.maxWidth * 0.92;
    } else if (breakpoint.device.name == "mediumHandset") {
      borderRadius = layoutConstraints.maxWidth * 0.0368;
      borderWidth = layoutConstraints.maxWidth * 0.01;
      singleFieldWidth = layoutConstraints.maxWidth * 0.15;
      singleFieldWidth = layoutConstraints.maxWidth * 0.125;
      wholeFieldsWidth = layoutConstraints.maxWidth * 0.92;
    } else {
      borderRadius = layoutConstraints.maxWidth * 0.0368;
      borderWidth = layoutConstraints.maxWidth * 0.01;
      singleFieldWidth = layoutConstraints.maxWidth * 0.15;
      singleFieldWidth = layoutConstraints.maxWidth * 0.125;
      wholeFieldsWidth = layoutConstraints.maxWidth * 0.92;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            appContext: context,
            enablePinAutofill: true,
            autoDismissKeyboard: true,
            enabled: (isDisabled == null || !isDisabled!),
            textInputAction: TextInputAction.done,
            length: 5,
            pinTheme: setupPinTheme(context),
            pastedTextStyle: TextStyle(
              fontWeight: Theme.of(context).textTheme.titleSmall!.fontWeight,
              fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
            ),
            controller: controller,
            keyboardType: TextInputType.number,
            scrollPadding: EdgeInsets.zero,
            onSubmitted: handleOnSubmitted,
            onChanged: (String? input) {
              if (input != null && input.replaceAll(" ", "") != "" && input.length == 5 && errorMsg == null) {
                handleOnSubmitted(input);
              }
            },
          ),
        ),
        if (errorMsg != null) buildErrorMsg(context)
      ],
    );
  }


  /// It is a helper method. It setups the appearance of the fields
  PinTheme setupPinTheme(BuildContext context) {
    return PinTheme.defaults(
      shape: PinCodeFieldShape.box,
      borderRadius: BorderRadius.circular(borderRadius),
      activeColor: Theme.of(context).colorScheme.outline,
      inactiveColor: Theme.of(context).colorScheme.outline,
      borderWidth: borderWidth,
      selectedColor: Theme.of(context).colorScheme.primary,
      errorBorderColor: Theme.of(context).colorScheme.error,
      fieldWidth: singleFieldWidth,
      fieldHeight: singleFieldWidth,
      fieldOuterPadding: EdgeInsets.zero
    );
  }


  /// It is a helper method. It builds the error message for the field.
  /// @pre-condition errorMsg is not null.
  Widget buildErrorMsg(BuildContext context) {
    return Container(
      width: wholeFieldsWidth,
      margin: const EdgeInsets.only(top: 2),
      child: Text(
        errorMsg!,
        overflow: TextOverflow.visible,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).colorScheme.error
        ),
      ),
    );
  }

}