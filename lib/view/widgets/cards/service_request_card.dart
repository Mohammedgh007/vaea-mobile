import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/service_type_enum.dart';
import 'package:vaea_mobile/view/formatters/service_type_formatter.dart';

/// It serves as a button to select which type of request that the user wants to submits.
class ServiceRequestCard extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  ServiceTypeEnum serviceType;
  void Function(ServiceTypeEnum serviceType) handleClick;

  // dimensions
  late double cardWidth;
  late double imageHeight;
  late double textsImageSpacer;
  late double textRowsSpacer;
  late double textPadding;

  /// It is a helper method for initState(). It initializes the dimension fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.43;
      imageHeight = layoutConstraints.maxWidth * 0.34;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxWidth * 0.012;
      textPadding = layoutConstraints.maxWidth * 0.01;
    } else if (breakpoint.device.name == "mediumHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.43;
      imageHeight = layoutConstraints.maxWidth * 0.34;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxWidth * 0.012;
      textPadding = layoutConstraints.maxWidth * 0.01;
    } else {
      cardWidth = layoutConstraints.maxWidth * 0.43;
      imageHeight = layoutConstraints.maxWidth * 0.34;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxWidth * 0.012;
      textPadding = layoutConstraints.maxWidth * 0.01;
    }
  }

  ServiceRequestCard({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.serviceType,
    required this.handleClick
  }){
    setupDimensions();
  }


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => handleClick(serviceType),
      child: Container(
        width: cardWidth,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(cardWidth * 0.15),
          boxShadow: [BoxShadow(blurRadius: 40, offset: Offset(0, 4), color: Color.fromRGBO(0, 0, 0, 0.05))],
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildImageSection(context),
              SizedBox(height: textsImageSpacer),
              buildServiceTitle(context),
              SizedBox(height: textRowsSpacer),
              buildServiceDescription(context),
              SizedBox(height: textsImageSpacer),
            ],
          ),
        ),
      ),
    );
  }


  /// It builds the image section in the card
  Widget buildImageSection(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(cardWidth * 0.15),
        topRight: Radius.circular(cardWidth * 0.15),
      ),
      child: Crab(
        tag: serviceType.toString(),
        child: Image.asset(
          ServiceTypeFormatter.getImagePath(serviceType),
          height: imageHeight,
          fit: BoxFit.fill,
        ),
      ),
    );
  }


  /// It builds the row that contains the service title
  Widget buildServiceTitle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: textPadding),
      child: Text(
        ServiceTypeFormatter.getTitle(serviceType, context),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }


  /// It builds the row that contains the service title
  Widget buildServiceDescription(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: textPadding),
      child: Text(
        ServiceTypeFormatter.getDescription(serviceType, context),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Theme.of(context).colorScheme.outlineVariant,
          fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
        ),
      ),
    );
  }

}