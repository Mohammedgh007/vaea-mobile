
import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// It encapsulates a single PageView child for IntroLayoutMobile.
class IntroPageContainer extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutBoxConstrains;
  int pageIndex; // 0 to 2
  String localImagePath;
  String titleStr;
  String bodyStr;
  Widget? actionsBtns;

  // dimensions
  late double imageHeight;
  late double titleContainerWidth;
  late double bodyContainerHeight;
  late double bodyContentSpacer;

  IntroPageContainer({
    super.key,
    required this.breakpoint,
    required this.layoutBoxConstrains,
    required this.pageIndex,
    required this.localImagePath,
    required this.titleStr,
    required this.bodyStr,
    this.actionsBtns
  }) {
    setupDimension();
  }

  /// It is a helper method for the constructor. It initializes the dimensions variables.
  void setupDimension() {
    if (breakpoint.device.name == "smallHandset") {
      imageHeight = layoutBoxConstrains.maxHeight * 0.7;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.8;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.5;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageHeight = layoutBoxConstrains.maxHeight * 0.70;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.79;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.5;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    } else {
      imageHeight = layoutBoxConstrains.maxHeight * 0.75;
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
        buildImageSection(),
        buildBody(context),
        buildTitleSection(context)
      ],
    );
  }


  /// It builds the image background
  Widget buildImageSection() {
    return Positioned( // image container
        top: 0,
        left: 0,
        right: 0,
        child: Image.asset(
          localImagePath,
          height: imageHeight,
          fit: BoxFit.fill,
        )
    );
  }


  /// It builds the bottom white body.
  Widget buildBody(BuildContext context) {
    double topRadius = layoutBoxConstrains.maxWidth * 0.14;
    double horizontalPadding = layoutBoxConstrains.maxWidth * 0.04;
    return Positioned( // text container
      bottom: 0,
      left: 0,
      right: 0,
      height: bodyContainerHeight,
      child: Container(
        height: bodyContainerHeight,
        alignment: Alignment.topCenter,
        padding: EdgeInsets.only(top: bodyContainerHeight * 0.2, right: horizontalPadding, left: horizontalPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(topRadius), topRight: Radius.circular(topRadius))
        ),
        child: Crab(
          tag: "beach",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buildBodyContent(context),
          ),
        ),
      )
    );
  }


  /// It is a helper method for buildBody(). It builds the content of the body.
  List<Widget> buildBodyContent(BuildContext context) {
    double? fontSize;
    if (breakpoint.device.name == "smallHandset") {
      fontSize = Theme.of(context).textTheme.bodyMedium!.fontSize;
    } else if (breakpoint.device.name == "mediumHandset") {
      fontSize = Theme.of(context).textTheme.bodyLarge!.fontSize;
    } else {
      fontSize = Theme.of(context).textTheme.bodyLarge!.fontSize;
    }
    return [
      Text(
        bodyStr,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          color: Theme.of(context).colorScheme.outlineVariant,
        ),
      ),
      SizedBox(height: bodyContainerHeight * 0.1),
      buildProgressDots(context),
      if (actionsBtns != null) SizedBox(height: bodyContainerHeight * 0.1),
      if (actionsBtns != null) actionsBtns!
    ];
  }


  /// It is a helper method for buildBodyContent(). It build the progress dots
  Widget buildProgressDots(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.circle,
          color: (pageIndex == 0) ? Color.fromRGBO(116, 116, 116, 1) : Color.fromRGBO(217, 217, 217, 1),
          size: titleContainerWidth * 0.05,
        ),
        SizedBox(width: titleContainerWidth * 0.1),
        Icon(
          Icons.circle,
          color: (pageIndex == 1) ? Color.fromRGBO(116, 116, 116, 1) : Color.fromRGBO(217, 217, 217, 1),
          size: titleContainerWidth * 0.05,
        ),
        SizedBox(width: titleContainerWidth * 0.1),
        Icon(
          Icons.circle,
          color: (pageIndex == 2) ? Color.fromRGBO(116, 116, 116, 1) : Color.fromRGBO(217, 217, 217, 1),
          size: titleContainerWidth * 0.05,
        ),
      ],
    );
  }


  /// It builds the title container with its text.
  Widget buildTitleSection(BuildContext context) {
    return Positioned( // title container
      //width: titleContainerWidth,
      left: (layoutBoxConstrains.maxWidth - titleContainerWidth) / 2,
      right: (layoutBoxConstrains.maxWidth - titleContainerWidth) / 2,
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
            titleStr,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
              color: Theme.of(context).colorScheme!.onBackground
            ),
          ),
        ),
      )
    );
  }

}