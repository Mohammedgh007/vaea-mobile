
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:vaea_mobile/data/model/my_home_details_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../buttons/icon_text_btn.dart';

/// It shows the details of current user unit.
class MyHomeCard extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  MyHomeDetailsModel homeDetails;

  // dimensions
  late double cardWidth;
  late double imageWidth;
  late double textsImageSpacer;
  late double textRowsSpacer;

  MyHomeCard({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.homeDetails
  }) {
    setupDimensions();
  }

  /// It is a helper method for initState(). It initializes the dimension fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      imageWidth = layoutConstraints.maxWidth * 0.34;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxHeight * 0.012;
    } else if (breakpoint.device.name == "mediumHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      imageWidth = layoutConstraints.maxWidth * 0.34;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxHeight * 0.012;
    } else {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      imageWidth = layoutConstraints.maxWidth * 0.34;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxHeight * 0.012;
    }
  }



  @override
  Widget build(BuildContext context) {

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(cardWidth * 0.05),
        border: Border.all(width: 0.1, color: Color.fromRGBO(151, 151, 151, 1)),
        boxShadow: [BoxShadow(blurRadius: 40, offset: Offset(0, 4), color: Color.fromRGBO(0, 0, 0, 0.05))]
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildImageSection(context),
            SizedBox(width: textsImageSpacer),
            buildTextsSection(context)
          ],
        ),
      ),
    );
  }


  /// It builds the image section in the card
  Widget buildImageSection(BuildContext context) {
    bool isLangRTL = AppLocalizations.of(context)!.localeName == "ar";
    BorderRadius languageBorderRadius;
    if (isLangRTL) {
      languageBorderRadius = BorderRadius.only(
        topRight: Radius.circular(cardWidth * 0.05),
        bottomRight: Radius.circular(cardWidth * 0.05),
      );
    } else {
      languageBorderRadius = BorderRadius.only(
        topLeft: Radius.circular(cardWidth * 0.05),
        bottomLeft: Radius.circular(cardWidth * 0.05),
      );
    }

    return ClipRRect(
      borderRadius: languageBorderRadius,
      child: Image.network(
        homeDetails.unitImages[0],
        width: imageWidth,
        fit: BoxFit.fill,
      ),
    );
  }


  /// It builds the whole text section that to the right of the image.
  Widget buildTextsSection(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: textRowsSpacer),
          buildMyHomeText(context),
          SizedBox(height: textRowsSpacer),
          buildSubTitlesText(context),
          navigateToButton(context),
          SizedBox(height: textRowsSpacer),
        ],
      ),
    );
  }

  /// It builds Myhome text.
  Widget buildMyHomeText(BuildContext context) {
    return FittedBox(
      child: Text(
        AppLocalizations.of(context)!.myHome,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
        ),
      ),
    );
  }


  /// It builds the subtitles that includes dates and unit name
  Widget buildSubTitlesText(BuildContext context) {
    List<String> subTitles = [
      "${AppLocalizations.of(context)!.moveInDate} ${DateFormat("yyyy-MM-dd").format(homeDetails.moveIn)}",
      "${AppLocalizations.of(context)!.moveOutDate} ${DateFormat("yyyy-MM-dd").format(homeDetails.moveOut)}",
      "${AppLocalizations.of(context)!.apartment} ${homeDetails.apartmentName} ${AppLocalizations.of(context)!.unitName} ${homeDetails.unitName}"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...subTitles.map((e) => Text(
          e,
          style: TextStyle(
            color: Theme.of(context).colorScheme.outlineVariant,
            fontSize: Theme.of(context).textTheme.labelMedium!.fontSize
          ),
        ))
      ],
    );
  }


  /// It handles build navigate button
  Widget navigateToButton(BuildContext context) {

    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () => MapsLauncher.launchCoordinates(homeDetails.lat, homeDetails.lon),
      buttonText: AppLocalizations.of(context)!.navigateHome,
      isIconTextOrderSwapped: true,
      iconData: Icons.navigate_next_rounded
    );
  }

}