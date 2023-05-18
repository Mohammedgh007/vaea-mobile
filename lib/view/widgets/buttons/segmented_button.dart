
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds the segmented button on VAEA theme. This button is used as tabs
/// to navigate between two similar sections.
class VAEASegmentedButton<T> extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  List<String> options;
  List<T> optionsValues;
  int selectedIndex;
  void Function(T clickedOptionIndex) handleSelect;

  // dimensions
  late double btnWidth;

  VAEASegmentedButton({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.options,
    required this.optionsValues,
    required this.selectedIndex,
    required this.handleSelect
  }) {
    setupDimensions();
  }


  /// It is a helper method for the constructor. It initializes the dimesnions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.77;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.77;
    } else {
      btnWidth = layoutConstraints.maxWidth * 0.77;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: SegmentedButton<T>(
        segments: buildSegments(context),
        selected: {optionsValues[selectedIndex]},
        multiSelectionEnabled: false,
        onSelectionChanged: (clicked) => handleSelect(clicked.first),
        emptySelectionAllowed: false,
        showSelectedIcon: false,
        style: ButtonStyle(
          visualDensity: VisualDensity.compact,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnWidth * 0.06)
          ))
        ),
      ),
    );
  }


  /// it a helper method. It builds the list of segmented.
  List<ButtonSegment<T>> buildSegments(BuildContext context) {
    List<ButtonSegment<T>> segments = [];
    for (int i = 0; i < options.length; i++) {
      segments.add(
          ButtonSegment(
            value: optionsValues[i],
            label: Text(
              options[i],
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                fontWeight: FontWeight.bold
              ),
            ),
          )
      );
    }

    return segments;
  }


}