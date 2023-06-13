
import 'package:breakpoint/breakpoint.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';
import 'package:vaea_mobile/view/formatters/gender_formatter.dart';

import '../../../data/model/searched_home_listing_model.dart';
import '../../formatters/district_formatter.dart';

/// It represents the info of a single search result for searching homes.
class SearchedHomeCard extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  SearchedHomeListingModel listingModel;
  void Function(int imageIndex) handleClickCard;

  SearchedHomeCard({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.listingModel,
    required this.handleClickCard
  });


  @override
  State<SearchedHomeCard> createState() => _SearchedHomeCardState();
}

class _SearchedHomeCardState extends State<SearchedHomeCard> {

  int currImageIndex = 0;

  // dimensions
  late double cardWidth;
  late double imageWidth;
  late double textsImageSpacer;
  late double textRowsSpacer;



  @override
  void initState() {
    super.initState();

    setupDimensions();
  }


  /// It is a helper method for initState(). It initializes the dimension fields.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      cardWidth = widget.layoutConstraints.maxWidth * 0.92;
      imageWidth = widget.layoutConstraints.maxWidth * 0.24;
      textsImageSpacer = widget.layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = widget.layoutConstraints.maxHeight * 0.012;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      cardWidth = widget.layoutConstraints.maxWidth * 0.92;
      imageWidth = widget.layoutConstraints.maxWidth * 0.24;
      textsImageSpacer = widget.layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = widget.layoutConstraints.maxHeight * 0.012;
    } else {
      cardWidth = widget.layoutConstraints.maxWidth * 0.92;
      imageWidth = widget.layoutConstraints.maxWidth * 0.24;
      textsImageSpacer = widget.layoutConstraints.maxWidth * 0.032;
      textRowsSpacer = widget.layoutConstraints.maxHeight * 0.012;
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => widget.handleClickCard(currImageIndex),
      child: Container(
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
              buildImageSection(),
              SizedBox(width: textsImageSpacer),
              buildTextsSection()
            ],
          ),
        ),
      ),
    );
  }


  /// It builds the image section in the card
  Widget buildImageSection() {
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
        widget.listingModel.imagesUrls[0],
        width: imageWidth,
        fit: BoxFit.fill,
      ),
    );
  }


  /// It builds the whole text section that to the right of the image.
  Widget buildTextsSection() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: textRowsSpacer),
          buildUnitDetailsRow(),
          SizedBox(height: textRowsSpacer),
          buildListingTitle(),
          SizedBox(height: textRowsSpacer),
          buildAvailabilityAndDistrictText(),
          SizedBox(height: textRowsSpacer),
        ],
      ),
    );
  }


  /// It builds the details of the apartment that are bathrooms, bedrooms, gender, and price.
  Widget buildUnitDetailsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildUnitDetails(),
        Spacer(),
        buildUnitPrice(),
        SizedBox(width: textsImageSpacer)
      ],
    );
  }


  /// It builds the number of bathrooms and bedrooms and the gender
  Widget buildUnitDetails() {
    Color detailsColor = (widget.listingModel.listingType == HomeType.shared)
      ? GenderFormatter.getGenderColor(context, widget.listingModel.gender)
      : Theme.of(context).colorScheme.outlineVariant;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.listingModel.bedrooms.toString(),
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
              color: detailsColor
            ),
          ),
          Icon(Icons.bed_rounded, size: imageWidth * 0.25, color: detailsColor),
          Text(
            widget.listingModel.bathrooms.toString(),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
                color: detailsColor
            ),
          ),
          Icon(Icons.bathtub_outlined, size: imageWidth * 0.2, color: detailsColor),
          if (widget.listingModel.listingType == HomeType.shared) GenderFormatter.buildGenderIcon(context, widget.listingModel.gender, null)
        ],
      ),
    );
  }

  /// It builds the unit price.
  Widget buildUnitPrice() {
    String outputStr = (widget.listingModel.listingType == HomeType.private)
      ? "${widget.listingModel.price} ${AppLocalizations.of(context)!.sar}/ ${AppLocalizations.of(context)!.unit}"
      : "${widget.listingModel.price} ${AppLocalizations.of(context)!.sar} / ${AppLocalizations.of(context)!.roomUnitCard}";

    return Text(
      outputStr,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
        color: Theme.of(context).colorScheme.primary
      ),
    );
  }


  /// It builds the listing title text.
  Widget buildListingTitle() {
    return FittedBox(
      child: Text(
        widget.listingModel.listingTitle,
        overflow: TextOverflow.fade,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.titleMedium!.fontSize
        ),
      ),
    );
  }


  /// It builds the availability and district text.
  Widget buildAvailabilityAndDistrictText() {
    String districtOutput = (AppLocalizations.of(context)!.localeName == "ar")
      ? "${AppLocalizations.of(context)!.districtLabel} ${DistrictFormatter.mapEnumToText(context, widget.listingModel.district)}"
      : "${DistrictFormatter.mapEnumToText(context, widget.listingModel.district)} ${AppLocalizations.of(context)!.districtLabel}";
    String availabilityOutput = (widget.listingModel.unitMaxCapacity == 1)
      ? ""
      : "\n${widget.listingModel.unitAvailableCapacity} ${AppLocalizations.of(context)!.availableUnitCard} ${AppLocalizations.of(context)!.outOfUnitCard} ${widget.listingModel.unitMaxCapacity}";
    String output = "$districtOutput$availabilityOutput";

    return Text(
      output,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
        color: Theme.of(context).colorScheme.outlineVariant
      ),
    );
  }



}