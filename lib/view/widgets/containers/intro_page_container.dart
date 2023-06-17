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

  late double imageTopMargin;
  late double textContentAreaHeight;
  late double bodyHorizontalPadding;
  late double bodyContentSpacer;
  late double imageContentSpacer;

  IntroPageContainer(
      {super.key,
      required this.breakpoint,
      required this.layoutBoxConstrains,
      required this.pageIndex,
      required this.localImagePath,
      required this.titleStr,
      required this.bodyStr,
      this.actionsBtns}) {
    setupDimension();
  }

  /// It is a helper method for the constructor. It initializes the dimensions variables.
  void setupDimension() {
    if (breakpoint.device.name == "smallHandset") {
      imageTopMargin = layoutBoxConstrains.maxHeight * 0.28;
      textContentAreaHeight = layoutBoxConstrains.maxHeight * 0.14;
      bodyHorizontalPadding = layoutBoxConstrains.maxWidth * 0.09;
      bodyContentSpacer = layoutBoxConstrains.maxWidth * 0.04;
      imageContentSpacer = layoutBoxConstrains.maxWidth * 0.03;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageTopMargin = layoutBoxConstrains.maxHeight * 0.28;
      textContentAreaHeight = layoutBoxConstrains.maxHeight * 0.14;
      bodyHorizontalPadding = layoutBoxConstrains.maxWidth * 0.09;
      bodyContentSpacer = layoutBoxConstrains.maxWidth * 0.09;
      imageContentSpacer = layoutBoxConstrains.maxWidth * 0.03;
    } else {
      imageTopMargin = layoutBoxConstrains.maxHeight * 0.28;
      textContentAreaHeight = layoutBoxConstrains.maxHeight * 0.14;
      bodyHorizontalPadding = layoutBoxConstrains.maxWidth * 0.09;
      bodyContentSpacer = layoutBoxConstrains.maxWidth * 0.09;
      imageContentSpacer = layoutBoxConstrains.maxWidth * 0.03;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildImageSection(),
        buildBody(context),
      ],
    );
  }

  /// It builds the image background
  Widget buildImageSection() {
    return Stack(
      children: [
        Positioned(
          top: imageTopMargin,
          left: imageContentSpacer,
          right: imageContentSpacer,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
            child: Image.asset(
              localImagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: pageIndex == 0 ? 0 : null,
          right: pageIndex == 1 ? 0 : null,
          bottom: -325,
          child: Image.asset('assets/images/slider_blur.png'),
        ),
      ],
    );
  }

  /// It builds the bottom white body.
  Widget buildBody(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: bodyHorizontalPadding,
        ),
        child: Crab(
          tag: "beach",
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildProgressSection(),
              SizedBox(height: bodyContentSpacer),
              buildTitleSection(context),
              Expanded(child: Container()),
              buildBodyContent(context),
              if (actionsBtns != null) SizedBox(height: bodyContentSpacer),
              if (actionsBtns != null) actionsBtns!,
            ],
          ),
        ),
      ),
    );
  }

  /// It is a helper method for buildBodyContent(). It build the progress indicators
  Widget buildProgressSection() {
    return Padding(
      padding: EdgeInsets.only(top: imageContentSpacer),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildProgressIndicator(0),
          const SizedBox(width: 6),
          buildProgressIndicator(1),
          const SizedBox(width: 6),
          buildProgressIndicator(2)
        ],
      ),
    );
  }

  /// It build the progress indicator
  Widget buildProgressIndicator(int index) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: (pageIndex == index)
              ? Colors.white
              : Colors.white.withOpacity(0.3),
        ),
        height: 2,
      ),
    );
  }

  /// It builds the title container with its text.
  Widget buildTitleSection(BuildContext context) {
    return Text(
      '${titleStr.split(' ').elementAt(0)} \n${titleStr.split(' ').elementAt(1)}',
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.displaySmall!.fontSize!,
        color: Theme.of(context).colorScheme.primaryContainer,
        height: 1,
      ),
    );
  }

  /// It is a helper method for buildBody(). It builds the content of the body.
  Widget buildBodyContent(BuildContext context) {
    double? fontSize;
    if (breakpoint.device.name == "smallHandset") {
      fontSize = Theme.of(context).textTheme.bodyMedium!.fontSize;
    } else if (breakpoint.device.name == "mediumHandset") {
      fontSize = Theme.of(context).textTheme.titleMedium!.fontSize;
    } else {
      fontSize = Theme.of(context).textTheme.titleMedium!.fontSize;
    }

    return Container(
      height: textContentAreaHeight,
      width: layoutBoxConstrains.maxWidth, // It will be constrained by the padding
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Text(
              bodyStr,
              textAlign: TextAlign.start,
              softWrap: true,
              style: TextStyle(
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
