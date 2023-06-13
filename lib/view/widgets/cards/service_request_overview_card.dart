
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaea_mobile/view/formatters/service_status_formatter.dart';
import 'package:vaea_mobile/view/formatters/service_type_formatter.dart';

import '../../../data/model/request_overview_model.dart';

/// It represents the overview info of a single submitted service request.
class ServiceRequestOverviewCard extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  ServiceRequestOverviewModel requestModel;

  // dimensions
  late double cardWidth;
  late double imageWidth;
  late double textsImageSpacer;
  late double textRowsSpacer;

  ServiceRequestOverviewCard({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.requestModel
  }) {
    setupDimensions();
  }

  /// It is a helper method for initState(). It initializes the dimension fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      imageWidth = layoutConstraints.maxWidth * 0.24;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxHeight * 0.012;
    } else if (breakpoint.device.name == "mediumHandset") {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      imageWidth = layoutConstraints.maxWidth * 0.24;
      textsImageSpacer = layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = layoutConstraints.maxHeight * 0.012;
    } else {
      cardWidth = layoutConstraints.maxWidth * 0.92;
      imageWidth = layoutConstraints.maxWidth * 0.24;
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
      child: Image.asset(
        ServiceTypeFormatter.getImagePath(requestModel.serviceType),
        width: imageWidth,
        fit: BoxFit.fill,
      ),
    );
  }


  /// It builds the section that contains the information text.
  Widget buildTextsSection(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: textRowsSpacer),
          ServiceStatusFormatter.buildStatusChip(context, requestModel.serviceStatus),
          buildServiceTypeTitle(context),
          SizedBox(height: textRowsSpacer),
          buildOrderOnRow(context),
          if (requestModel.appointmentDate != null) buildAppointmentOnRow(context),
          SizedBox(height: textRowsSpacer),
        ],
      )
    );
  }


  /// It builds the listing title text.
  Widget buildServiceTypeTitle(BuildContext context) {
    String titleOutput = "${ServiceTypeFormatter.getTitle(requestModel.serviceType, context)} ${requestModel.requestId}";
    return FittedBox(
      child: Text(
        titleOutput,
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
        ),
      ),
    );
  }


  /// It builds the order now row.
  Widget buildOrderOnRow(BuildContext context) {
    return Text(
      "${AppLocalizations.of(context)!.requestedOn} ${DateFormat("HH:mm yyyy-MM-dd").format(requestModel.orderDate)}",
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
        color: Theme.of(context).colorScheme.outlineVariant
      )
    );
  }


  /// It builds the order now row.
  Widget buildAppointmentOnRow(BuildContext context) {
    return Text(
        "${AppLocalizations.of(context)!.appointmentOn} ${DateFormat("HH:mm yyyy-MM-dd").format(requestModel.appointmentDate!)}",
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
            color: Theme.of(context).colorScheme.outlineVariant
        )
    );
  }

}