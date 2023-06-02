
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// It is a customized date picker field to have VAEA theme.
class VAEADatePickerField extends StatelessWidget {

  final Breakpoint breakpoint;
  final BoxConstraints layoutConstraints;
  final DateTime? selectedDate;
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String labelStr;
  final String hintStr;
  final double? width;
  /// If it is null, then the field is not in error state
  final String? errorMsg;
  final void Function(DateTime input) handleOnSubmitted;

  // dimensions
  late double fieldWidth;
  late double labelFieldSpacer;
  late double fieldBorderWidth;


  VAEADatePickerField({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.selectedDate,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.labelStr,
    required this.hintStr,
    this.width,
    this.errorMsg,
    required this.handleOnSubmitted,
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
          GestureDetector(
            onTap: () => handleClickField(context),
            child: Container(
              width: fieldWidth,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: BorderRadius.circular(fieldWidth * 0.04),
                border: Border.all(
                  color: (errorMsg != null) ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.outline,
                  width: fieldBorderWidth * 0.5
                )
              ),
              child: getFieldContent(context),
            ),
          ),
          if (errorMsg != null) buildErrorMsg(context)
        ],
      ),
    );
  }


  /// It is a helper method. It either builds the hint text of the selected date text.
  Widget getFieldContent(BuildContext context) {
    String textOutput = (selectedDate == null)
      ? hintStr
      : DateFormat("yyyy-MM-dd").format(selectedDate!);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          textOutput,
          style: TextStyle(
            color: (selectedDate != null)
              ? Theme.of(context).colorScheme.onBackground
              : Theme.of(context).colorScheme.outlineVariant
          ),
        ),
        Icon(Icons.date_range_rounded, color: Theme.of(context).colorScheme.outline)
      ],
    );
  }


  /// It shows the dialog of picking a date
  Future<void> handleClickField(BuildContext context) async {
    DateTime? selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selected != null) {
      handleOnSubmitted(selected);
    }
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