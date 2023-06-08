
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds a text button with an icon based on VAEA theme.
class IconTextBtn extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  void Function() handleClick;
  String buttonText;
  /// It optionally allows to include an icon.
  IconData iconData;
  double? width;
  double? fontSize;
  Color? btnColor;
  bool isIconTextOrderSwapped = false;

  // dimensions
  late double btnWidth;
  late double btnFontSize;
  late double iconTextSpacer;

  IconTextBtn({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleClick,
    required this.buttonText,
    required this.iconData,
    this.width,
    this.fontSize,
    this.btnColor,
    this.isIconTextOrderSwapped = false
  }){
    setupDimensions();
  }

  /// It is a helper method for the constructor. It setups the dimensions.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      iconTextSpacer = layoutConstraints.maxWidth * 0.03;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth =  (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      iconTextSpacer = layoutConstraints.maxWidth * 0.03;
    } else {
      btnWidth =  (width == null) ? layoutConstraints.maxWidth * 0.92 : width!;
      iconTextSpacer = layoutConstraints.maxWidth * 0.03;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: btnWidth,
      child: TextButton(
        onPressed: handleClick,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero
        ),
        child: getButtonContent(context),
      )
    );
  }

  Widget getButtonContent(BuildContext context) {
    btnFontSize = (fontSize != null) ? fontSize! : Theme.of(context).textTheme.titleSmall!.fontSize!;
    btnColor = (btnColor == null) ? Theme.of(context).colorScheme.primary : btnColor;
    if (isIconTextOrderSwapped){
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            buttonText,
            style: TextStyle(
              fontSize: btnFontSize,
              fontWeight: FontWeight.bold,
              color: btnColor
            ),
          ),
          SizedBox(width: iconTextSpacer),
          Icon(iconData, color: btnColor)
        ],
      );
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(iconData, color: btnColor),
          SizedBox(width: iconTextSpacer),
          Text(
          buttonText,
          style: TextStyle(
            fontSize: btnFontSize,
            fontWeight: FontWeight.bold,
            color: btnColor
          ),
          ),
        ],
      );
    }
  }

}