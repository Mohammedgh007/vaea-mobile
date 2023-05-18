
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It is a customized text field to have VAEA theme.
class VAEATextField extends StatelessWidget {

  final Breakpoint breakpoint;
  final BoxConstraints layoutConstraints;
  final TextEditingController controller;
  final String labelStr;
  final String hintStr;
  final Icon? icon;
  final FocusNode? focus;
  /// It controls the text height. If null it is one line.
  final int? minLinesNum;
  final double? width;
  final bool? isDisabled;
  /// If it is null, then the field is not in error state
  final String? errorMsg;
  final TextInputAction textInputAction;
  final void Function(String input)? handleOnSubmitted;
  final bool isTextObscure;

  // dimensions
  late double fieldWidth;
  late double labelFieldSpacer;
  late double fieldBorderWidth;


  VAEATextField({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.controller,
    required this.labelStr,
    required this.hintStr,
    this.icon,
    this.focus,
    this.minLinesNum,
    this.width,
    this.isDisabled,
    this.errorMsg,
    required this.textInputAction,
    this.handleOnSubmitted,
    required this.isTextObscure
  }) {
    setupDimension();
  }


  /// It is a helper method for the constructor. It initializes the dimensions.
  void setupDimension() {
    if (breakpoint.device.name == "smallHandset") {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      fieldBorderWidth = layoutConstraints.maxWidth * 0.01;
    } else if(breakpoint.device.name == "mediumHandset") {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      fieldBorderWidth = layoutConstraints.maxWidth * 0.01;
    } else {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      fieldBorderWidth = layoutConstraints.maxWidth * 0.01;
    }
  }


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelStr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: labelFieldSpacer),
          Container(
            width: fieldWidth,
            child: getTextField(context),
          ),
          if (errorMsg != null) buildErrorMsg(context)
        ],
      ),
    );
  }


  /// It is a helper method to build. It creates the inner content of the text field
  /// container.
  Widget getTextField(BuildContext context) {
    return TextField(
      minLines: (minLinesNum == null) ? null : minLinesNum,
      maxLines: (minLinesNum == null) ? 1 : null,
      style: TextStyle(
        fontWeight: Theme.of(context).textTheme.titleSmall!.fontWeight,
        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: fieldBorderWidth
          ),
          borderRadius: BorderRadius.circular(fieldWidth * 0.04)
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: (errorMsg != null) ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.outline,
            width: fieldBorderWidth * 0.5
          ),
          borderRadius: BorderRadius.circular(fieldWidth * 0.04),
        ),
        enabled: (isDisabled == null || isDisabled!),
        hintText: hintStr,
        hintStyle: TextStyle(
          color: Colors.black45,
          fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight
        ),
        suffixIcon: icon
      ),
      controller: controller,
      focusNode: focus,
      textInputAction: textInputAction,
      onSubmitted: handleOnSubmitted,
      obscureText: isTextObscure,
      obscuringCharacter: "*",
    );
  }


  /// It is a helper method. It builds the error message for the field.
  /// @pre-condition errorMsg is not null.
  Widget buildErrorMsg(BuildContext context) {
    return Container(
      width: fieldWidth,
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