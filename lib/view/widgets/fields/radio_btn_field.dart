
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds a label with radio buttons based on VAEA theme.
class VAEARadioBtnField<T> extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  double? width;

  /// the can be built without a label
  String? labelStr;
  List<String> options;
  List<T> optionsVal;
  T selected;

  void Function(T selected) handleSelect;

  // dimensions
  late double fieldWidth;
  late double labelFieldSpacer;
  late double radioIconBorderWidth;
  late double radioIconSize;
  late double optionIconTextSpacer;
  late double optionsSpacer;

  VAEARadioBtnField({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    this.width,
    required this.labelStr,
    required this.options,
    required this.optionsVal,
    required this.selected,
    required this.handleSelect
  }) {
    setupDimensions();
  }

  /// It is a helper method for the constructor. It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      radioIconBorderWidth = layoutConstraints.maxWidth * 0.008;
      radioIconSize = layoutConstraints.maxWidth * 0.058;
      optionIconTextSpacer = layoutConstraints.maxWidth * 0.045;
      optionsSpacer = layoutConstraints.maxHeight * 0.03;
    } else if(breakpoint.device.name == "mediumHandset") {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      radioIconBorderWidth = layoutConstraints.maxWidth * 0.008;
      radioIconSize = layoutConstraints.maxWidth * 0.058;
      optionIconTextSpacer = layoutConstraints.maxWidth * 0.045;
      optionsSpacer = layoutConstraints.maxHeight * 0.03;
    } else {
      fieldWidth = (width != null) ?  width! : layoutConstraints.maxWidth * 0.92;
      labelFieldSpacer = layoutConstraints.maxHeight * 0.001;
      radioIconBorderWidth = layoutConstraints.maxWidth * 0.008;
      radioIconSize = layoutConstraints.maxWidth * 0.058;
      optionIconTextSpacer = layoutConstraints.maxWidth * 0.045;
      optionsSpacer = layoutConstraints.maxHeight * 0.03;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: fieldWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelStr != null) Text(
            labelStr!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          if (labelStr != null) SizedBox(height: labelFieldSpacer),
          buildOptions(context)
        ],
      ),
    );
  }


  /// It builds the whole options of radi buttons
  Widget buildOptions(BuildContext context) {
    // prepare the list of options
    List<Widget> spacedOptions = [];
    for (int i = 0; i < options.length; i++) {
      spacedOptions.add(buildOneOption(context, i));
      if (i + 1 < options.length) {
        spacedOptions.add(SizedBox(height: optionsSpacer));
      }
    }
    
    // return the column of separated children
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: spacedOptions,
    );
  }


  /// It is a helper method for buildOptions. It builds a single option.
  Widget buildOneOption(BuildContext context, int optionIndex) {
    return GestureDetector(
      onTap: () => handleSelect(optionsVal[optionIndex]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: radioIconSize,
            height: radioIconSize,
            child: Stack(
              children: [
                Positioned.fill(child: Container( // outer circle
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    border: Border.all(color: Theme.of(context).colorScheme.secondary, width: radioIconBorderWidth)
                  ),
                ),),
                if (optionsVal[optionIndex] == selected) Positioned(
                    top: radioIconSize * 0.2,
                    right: radioIconSize * 0.2,
                    child: Container( // inner circle
                    width: radioIconSize * 0.6,
                    height: radioIconSize * 0.6,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(300),
                        color: Theme.of(context).colorScheme.secondary
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: optionIconTextSpacer),
          Text(
            options[optionIndex],
            style: TextStyle(
              fontSize: Theme.of(context)!.textTheme.titleMedium!.fontSize,
              fontWeight: Theme.of(context)!.textTheme.titleMedium!.fontWeight
            ),
          )
        ],
      ),
    );
  }


}