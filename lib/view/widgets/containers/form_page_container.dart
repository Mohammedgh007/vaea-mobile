
import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

/// It encapsulates a single PageView child for IntroLayoutMobile.
class FormPageContainer extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutBoxConstrains;
  Widget pageForm;
  String pageTitle;

  // dimensions
  late double imageHeight;
  late double logoTopPadding;
  late double titleContainerWidth;
  late double bodyContainerHeight;
  late double bodyContentSpacer;

  FormPageContainer({
    super.key,
    required this.breakpoint,
    required this.layoutBoxConstrains,
    required this.pageForm,
    required this.pageTitle
  }) {
    setupDimension();
  }

  /// It is a helper method for the constructor. It initializes the dimensions variables.
  void setupDimension() {
    if (breakpoint.device.name == "smallHandset") {
      imageHeight = layoutBoxConstrains.maxHeight * 0.7;
      logoTopPadding = imageHeight * 0.1;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.8;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.5;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageHeight = layoutBoxConstrains.maxHeight * 0.70;
      logoTopPadding = imageHeight * 0.1;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.79;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.5;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    } else {
      imageHeight = layoutBoxConstrains.maxHeight * 0.75;
      logoTopPadding = imageHeight * 0.1;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.83;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.5;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        buildImageSection(context),
        buildBody(context),
        buildTitleSection(context)
      ],
    );
  }


  /// It builds the image background
  Widget buildImageSection(BuildContext context) {
    return Positioned( // image container
        top: 0,
        left: 0,
        right: 0,
        height: imageHeight,
        child: Container(
          width: double.infinity,
          height: imageHeight,
          color: Theme.of(context).colorScheme.secondary,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: logoTopPadding),
          child: Crab(
            tag: "signup",
            child: SvgPicture.asset(
              "assets/logos/app_logo_color_transparent.svg",
              width: imageHeight / 2,
              height: imageHeight / 2,
              alignment: Alignment.topCenter,
            ),
          ),
        )
    );
  }


  /// It builds the bottom white body.
  Widget buildBody(BuildContext context) {
    double topRadius = layoutBoxConstrains.maxWidth * 0.14;
    double horizontalPadding = layoutBoxConstrains.maxWidth * 0.04;
    return KeyboardVisibilityBuilder(
      builder: (BuildContext context, isKeyboardVisible) => Positioned( // text container
          bottom: (isKeyboardVisible) ? MediaQuery.of(context).viewPadding.bottom : 0,
          top: (isKeyboardVisible) ? layoutBoxConstrains.maxHeight * 0.04 : null,
          left: 0,
          right: 0,
          height: (isKeyboardVisible) ? null : bodyContainerHeight,
          child: Container(
            height: double.infinity,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: bodyContainerHeight * 0.2, right: horizontalPadding, left: horizontalPadding),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(topRadius), topRight: Radius.circular(topRadius))
            ),
            child: SingleChildScrollView(child: pageForm),
          )
      ),
    );
  }


  /// It builds the title container with its text.
  Widget buildTitleSection(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (BuildContext context, isKeyboardVisible) => Positioned( // title container
          left: (layoutBoxConstrains.maxWidth - titleContainerWidth) / 2,
          right: (layoutBoxConstrains.maxWidth - titleContainerWidth) / 2,
          top: (isKeyboardVisible) ? 0 : null,
          child: Container(
            width: titleContainerWidth,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: layoutBoxConstrains.maxHeight * 0.02, horizontal: layoutBoxConstrains.maxHeight * 0.02),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all( Radius.circular(titleContainerWidth * 0.07)),
                border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1),
                boxShadow: const [
                  BoxShadow(color: Color.fromRGBO(184, 230, 243, 0.3), blurRadius: 4, offset: Offset(0, 3))
                ]
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                pageTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                    color: Theme.of(context).colorScheme!.onBackground
                ),
              ),
            ),
          )
      ),
    );
  }

}