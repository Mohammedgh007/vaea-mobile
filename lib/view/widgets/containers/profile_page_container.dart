
import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/svg.dart';

/// It encapsulates a single PageView child for IntroLayoutMobile.
class ProfilePageContainer extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutBoxConstrains;
  String? imageProfileUrl;
  String pageTitle;
  List<Widget> btnList;

  // dimensions
  late double imageSectionHeight;
  late double imageTopPadding;
  late double imageWidth;
  late double titleContainerWidth;
  late double bodyContainerHeight;
  late double bodyContentSpacer;

  ProfilePageContainer({
    super.key,
    required this.breakpoint,
    required this.layoutBoxConstrains,
    required this.imageProfileUrl,
    required this.pageTitle,
    required this.btnList
  }) {
    setupDimension();
  }

  /// It is a helper method for the constructor. It initializes the dimensions variables.
  void setupDimension() {
    if (breakpoint.device.name == "smallHandset") {
      imageSectionHeight = layoutBoxConstrains.maxHeight * 0.4;
      imageWidth = layoutBoxConstrains.maxWidth * 0.4;
      imageTopPadding = imageWidth / 5;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.8;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.45;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageSectionHeight = layoutBoxConstrains.maxHeight * 0.4;
      imageWidth = layoutBoxConstrains.maxWidth * 0.4;
      imageTopPadding = imageWidth / 5;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.79;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.45;
      bodyContentSpacer =bodyContainerHeight * 0.1;
    } else {
      imageSectionHeight = layoutBoxConstrains.maxHeight * 0.4;
      imageWidth = layoutBoxConstrains.maxWidth * 0.4;
      imageTopPadding = imageWidth / 5;
      titleContainerWidth = layoutBoxConstrains.maxWidth * 0.83;
      bodyContainerHeight = layoutBoxConstrains.maxHeight * 0.45;
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
        height: imageSectionHeight,
        child: Container(
          width: double.infinity,
          height: imageSectionHeight,
          color: Theme.of(context).colorScheme.tertiary,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: imageTopPadding),
          child: (imageProfileUrl == null) ? null : ClipOval(
            child: buildImage(context)
          ),
        )
    );
  }


  /// It is a helper method for buildImageSection. It builds the image its
  /// assuming the container and the clip is set up.
  Widget buildImage(BuildContext context) {
    return (imageProfileUrl != null)
        ? Image.network(
      imageProfileUrl!,
      width: imageWidth,
      height: imageWidth,
      alignment: Alignment.center,
      fit: BoxFit.fill,
    )
        : Image.network(
      imageProfileUrl!,
      width: imageWidth,
      height: imageWidth,
      alignment: Alignment.center,
      fit: BoxFit.fill,
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
          child: SingleChildScrollView(
            child: Column(
              children: btnList,
            )
          ),
        )
    );
  }


  /// It builds the title container with its text.
  Widget buildTitleSection(BuildContext context) {
    return Positioned(
      left: (layoutBoxConstrains.maxWidth - titleContainerWidth) / 2,
      right: (layoutBoxConstrains.maxWidth - titleContainerWidth) / 2,
      bottom: bodyContainerHeight - layoutBoxConstrains.maxHeight * 0.05,
      child: Container(
        width: titleContainerWidth,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: layoutBoxConstrains.maxHeight * 0.025, horizontal: layoutBoxConstrains.maxHeight * 0.02),
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
    );
  }

}