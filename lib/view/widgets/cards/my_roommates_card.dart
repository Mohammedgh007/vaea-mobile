
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../data/model/my_home_details_model.dart';

/// It builds the card for HomeScreen that shows the roommates info
class MyRoommatesCards extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  MyHomeDetailsModel homeDetails;

  // dimensions
  late double cardWidth;
  late double cardPadding;
  late double imageWidth;
  late double textsImageSpacer;
  late double roommatesRowsSpacer;

  MyRoommatesCards({
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
      cardPadding = layoutConstraints.maxWidth * 0.04;
      imageWidth = layoutConstraints.maxWidth * 0.20;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      roommatesRowsSpacer = layoutConstraints.maxHeight * 0.015;
    } else if (breakpoint.device.name == "mediumHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      cardPadding = layoutConstraints.maxWidth * 0.04;
      imageWidth = layoutConstraints.maxWidth * 0.20;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      roommatesRowsSpacer = layoutConstraints.maxHeight * 0.015;
    } else {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      cardPadding = layoutConstraints.maxWidth * 0.04;
      imageWidth = layoutConstraints.maxWidth * 0.20;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      roommatesRowsSpacer = layoutConstraints.maxHeight * 0.015;
    }
  }

  
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: cardWidth,
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(cardWidth * 0.05),
          border: Border.all(width: 0.1, color: const Color.fromRGBO(151, 151, 151, 1)),
          boxShadow: const [BoxShadow(blurRadius: 40, offset: Offset(0, 4), color: Color.fromRGBO(0, 0, 0, 0.05))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildMyRoommatesText(context),
          SizedBox(height: roommatesRowsSpacer * 1.2),
          buildRoommatesRows(context),
        ],
      ),
    );
  }


  /// It builds my roommates title text.
  Widget buildMyRoommatesText(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.roommates,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        fontWeight: FontWeight.normal),
    );
  }
  
  /// It builds the rows of the roommates
  Widget buildRoommatesRows(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < homeDetails.roommates!.length; i++) {
      if (i == 0) {
        rows.add(buildRoommateRow(context, i));
      } else {
        rows.add(SizedBox(height: roommatesRowsSpacer));
        rows.add(buildRoommateRow(context, i));
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    );
  }
  
  
  /// It is a helper method for buildRoommatesRows. It builds a single roomate row.
  Widget buildRoommateRow(BuildContext context, int roommateIndex) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: (homeDetails.roommates![roommateIndex].roommateImage != null)
              ? Image.network(homeDetails.roommates![roommateIndex].roommateImage!, width: imageWidth, height: imageWidth, fit: BoxFit.fill,)
              : Image.asset("assets/logos/profile_logo.png", width: imageWidth, height: imageWidth, fit: BoxFit.fill),
          ),
          SizedBox(width: textsImageSpacer),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${homeDetails.roommates![roommateIndex].firstName} ${homeDetails.roommates![roommateIndex].lastname}",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelLarge!.fontSize,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "${AppLocalizations.of(context)!.unitName} ${homeDetails.roommates![roommateIndex].unitName}",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
                  color: Theme.of(context)!.colorScheme.outlineVariant
                ),
              )
            ],
          )
        ],
      ),
    );
  }
  
}