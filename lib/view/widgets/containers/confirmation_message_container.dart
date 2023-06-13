
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';

/// It is used to contain the body that lists a confirmation message.
class ConfirmationMessageContainer extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  String titleMessage;
  String subTitleMessage;
  String actionButtonTitle;
  void Function() handleClickActionButton;

  // dimensions
  late double iconSize;
  late double containerPadding;
  late double textSpacer;
  late double textButtonSpacer;
  late double? titleFontSize;

  ConfirmationMessageContainer({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.titleMessage,
    required this.subTitleMessage,
    required this.actionButtonTitle,
    required this.handleClickActionButton
  });


  /// It is a helper method for the build. It initializes the fields of dimensions
  void setupDimensions(BuildContext context) {
    if (breakpoint.device.name == "smallHandset") {
      iconSize = layoutConstraints.maxWidth * 0.7;
      containerPadding = layoutConstraints.maxWidth * 0.04;
      textSpacer = layoutConstraints.maxHeight * 0.02;
      textButtonSpacer = layoutConstraints.maxHeight * 0.06;
      titleFontSize = Theme.of(context).textTheme.titleLarge!.fontSize;
    } else if (breakpoint.device.name == "mediumHandset") {
      iconSize = layoutConstraints.maxWidth * 0.7;
      containerPadding = layoutConstraints.maxWidth * 0.04;
      textSpacer = layoutConstraints.maxHeight * 0.02;
      textButtonSpacer = layoutConstraints.maxHeight * 0.06;
      titleFontSize = Theme.of(context).textTheme.headlineMedium!.fontSize;
    } else {
      iconSize = layoutConstraints.maxWidth * 0.7;
      containerPadding = layoutConstraints.maxWidth * 0.04;
      textSpacer = layoutConstraints.maxHeight * 0.02;
      textButtonSpacer = layoutConstraints.maxHeight * 0.06;
      titleFontSize = Theme.of(context).textTheme.headlineMedium!.fontSize;
    }
  }

  @override
  Widget build(BuildContext context) {
    setupDimensions(context);

    return Padding(
      padding: EdgeInsets.all(containerPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildIconSection(context),
          buildTitleSection(context),
          SizedBox(height: textSpacer),
          buildSubTitleSection(context),
          SizedBox(height: textButtonSpacer),
          PrimaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: handleClickActionButton,
            buttonText: actionButtonTitle
          )
        ],
      ),
    );
  }


  /// It builds the check icon.
  Widget buildIconSection(BuildContext context) {
    return Icon(
      Icons.check_circle_outline,
      color: Theme.of(context).colorScheme.primary,
      size: iconSize,
    );
  }


  /// It builds the text of the message title.
  Widget buildTitleSection(BuildContext context) {
    return Text(
      titleMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: titleFontSize,
        color: Theme.of(context).colorScheme.onBackground
      ),
    );
  }


  /// It builds the text of the message title.
  Widget buildSubTitleSection(BuildContext context) {
    return Text(
      subTitleMessage,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
          color: Theme.of(context).colorScheme.outlineVariant
      ),
    );
  }

}
