
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It creates the dropdown field input based on VAEA theme. The selected value
/// is saved by handleChange.
class VAEADropdownField<T> extends StatelessWidget {

  final Breakpoint breakpoint;
  final BoxConstraints layoutConstraints;
  final void Function(T? selectedValue) handleChange;
  /// It stores all the displayed options
  final List<String> options;
  /// It stores the values in the same order as options.
  final List<T> optionsValues;
  /// It is used to control the selected value manually. Then, this widget should
  /// be a child of ValueListenableBuilder.
  final T? currValue;
  final String labelStr;
  final String? hintStr;
  final FocusNode? focus;
  final double? width;
  final bool? isDisabled;
  /// If it is null, then the field is not in error state
  final String? errorMsg;
  final void Function(String input)? handleOnSubmitted;

  // dimensions
  late double fieldWidth;
  late double labelFieldSpacer;
  late double fieldBorderWidth;


  VAEADropdownField({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleChange,
    required this.options,
    required this.optionsValues,
    this.currValue,
    required this.labelStr,
    required this.hintStr,
    this.focus,
    this.width,
    this.isDisabled,
    this.errorMsg,
    this.handleOnSubmitted,
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelStr,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: labelFieldSpacer),
        Container(
          width: fieldWidth,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: (errorMsg != null) ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.outline,
              width: fieldBorderWidth * 0.5
            ),
            borderRadius: BorderRadius.circular(fieldWidth * 0.04)
          ),
          child: getDropdownBtn(context),
        ),
        if (errorMsg != null) buildErrorMsg(context)
      ],
    );
  }


  /// It is a helper method. It builds the dropdown button for the field.
  Widget getDropdownBtn(BuildContext context) {
    // setup the items list.
    List< DropdownMenuItem<T> > items = [
      if (hintStr != null) DropdownMenuItem<T>(value: null, child: Text(hintStr!))
    ];
    for (int i = 0; i < options.length; i++) {
      items.add( DropdownMenuItem<T>(value: optionsValues[i], child: Text(options[i])) );
    }

    return DropdownButtonFormField(
      value: currValue,
      items: items,
      onChanged: (T? selectedValue) => handleChange(selectedValue),
      decoration: InputDecoration.collapsed(hintText: hintStr),
      focusNode: focus,
      isExpanded: true,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: Theme.of(context).colorScheme.onBackground,
        fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
        fontWeight: Theme.of(context).textTheme.titleSmall!.fontWeight
      ),
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