import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds the elevated button based on VAEA theme
class PrimaryBtn extends StatelessWidget {
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
  bool disabled;

  // dimensions
  late double btnWidth;
  late double btnVerticalPadding;
  late double btnFontSize;

  PrimaryBtn(
      {super.key,
      required this.breakpoint,
      required this.layoutConstraints,
      required this.handleClick,
      required this.buttonText,
      this.iconData,
      this.width,
      this.verticalPadding,
      this.fontSize,
      this.isIconTextOrderSwapped = false,
      this.disabled = false}) {
    setupDimensions();
  }

  /// It is a helper method for the constructor. It setups the dimensions.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      btnVerticalPadding = (verticalPadding == null)
          ? layoutConstraints.maxHeight * 0.02
          : verticalPadding!;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth = (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      btnVerticalPadding = (verticalPadding == null)
          ? layoutConstraints.maxHeight * 0.02
          : verticalPadding!;
    } else {
      btnWidth = (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      btnVerticalPadding = (verticalPadding == null)
          ? layoutConstraints.maxHeight * 0.02
          : verticalPadding!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: ElevatedButton(
        onPressed: disabled ? null : handleClick,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: btnVerticalPadding),
          child: getButtonContent(context),
        ),
      ),
    );
  }

  /// It generates the text and the icon for the button
  Widget getButtonContent(BuildContext context) {
    btnFontSize = (fontSize != null)
        ? fontSize!
        : Theme.of(context).textTheme.titleLarge!.fontSize!;

    if (iconData == null) {
      return Text(
        buttonText,
        style: TextStyle(fontSize: btnFontSize, fontWeight: FontWeight.bold),
      );
    } else if (isIconTextOrderSwapped && iconData != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style:
                TextStyle(fontSize: btnFontSize, fontWeight: FontWeight.bold),
          ),
          Icon(iconData, color: Theme.of(context).colorScheme.onPrimary)
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, color: Theme.of(context).colorScheme.onPrimary),
          Text(
            buttonText,
            style:
                TextStyle(fontSize: btnFontSize, fontWeight: FontWeight.bold),
          ),
        ],
      );
    }
  }
}
