
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds the outlined button based on VAEA theme
class SecondaryBtn extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  void Function() handleClick;
  String buttonText;
  /// It optionally allows to include an icon.
  IconData? iconData;
  double? width;
  double? verticalPadding;
  double? fontSize;
  bool isIconTextOrderSwapped = false;

  // dimensions
  late double btnWidth;
  late double btnVerticalPadding;
  late double btnFontSize;
  late double btnBorderWidth;

  SecondaryBtn({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleClick,
    required this.buttonText,
    this.iconData,
    this.width,
    this.verticalPadding,
    this.fontSize,
    this.isIconTextOrderSwapped = false
  }) {
    setupDimensions();
  }

  /// It is a helper method for the constructor. It setups the dimensions.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      btnVerticalPadding = (verticalPadding == null) ? layoutConstraints.maxHeight * 0.02 : verticalPadding!;
      btnBorderWidth = layoutConstraints.maxWidth * 0.01;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth =  (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      btnVerticalPadding = (verticalPadding == null) ? layoutConstraints.maxHeight * 0.02 : verticalPadding!;
      btnBorderWidth = layoutConstraints.maxWidth * 0.01;
    } else {
      btnWidth =  (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      btnVerticalPadding = (verticalPadding == null) ? layoutConstraints.maxHeight * 0.02 : verticalPadding!;
      btnBorderWidth = layoutConstraints.maxWidth * 0.01;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: btnWidth,
      child: OutlinedButton(
        onPressed: handleClick,
        style: OutlinedButton.styleFrom(
          side: BorderSide(width: btnBorderWidth, color: Theme.of(context).colorScheme.primary)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: btnVerticalPadding),
          child: getButtonContent(context),
        ),
      ),
    );
  }


  /// It generates the text and the icon for the button
  Widget getButtonContent(BuildContext context) {
    btnFontSize = (fontSize != null) ? fontSize! : Theme.of(context).textTheme.titleLarge!.fontSize!;

    if (iconData == null) {
      return Text(
        buttonText,
        style: TextStyle(
          fontSize: btnFontSize,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary
        ),
      );
    } else if (isIconTextOrderSwapped && iconData != null){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyle(
              fontSize: btnFontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
          Icon(iconData, color: Theme.of(context).colorScheme.primary)
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, color: Theme.of(context).colorScheme.primary),
          Text(
            buttonText,
            style: TextStyle(
              fontSize: btnFontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary
            ),
          ),
        ],
      );
    }
  }

}