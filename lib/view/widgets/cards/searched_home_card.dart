
import 'package:breakpoint/breakpoint.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  late double imageSize;
  late double stepperIconSize;
  late double imageTextSpacer; // between title and image
  late double textSpacer;

  @override
  void initState() {
    super.initState();

    setupDimensions();
  }


  /// It is a helper method for initState(). It initializes the dimension fields.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      imageSize = widget.layoutConstraints.maxWidth * 0.95;
      stepperIconSize = widget.layoutConstraints.maxWidth * 0.03;
      imageTextSpacer = widget.layoutConstraints.maxHeight * 0.0098;
      textSpacer = widget.layoutConstraints.maxHeight * 0.0033;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      imageSize = widget.layoutConstraints.maxWidth * 0.95;
      stepperIconSize = widget.layoutConstraints.maxWidth * 0.03;
      imageTextSpacer = widget.layoutConstraints.maxHeight * 0.0098;
      textSpacer = widget.layoutConstraints.maxHeight * 0.0033;
    } else {
      imageSize = widget.layoutConstraints.maxWidth * 0.92;
      stepperIconSize = widget.layoutConstraints.maxWidth * 0.03;
      imageTextSpacer = widget.layoutConstraints.maxHeight * 0.0098;
      textSpacer = widget.layoutConstraints.maxHeight * 0.0033;
    }
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => widget.handleClickCard(currImageIndex),
      child: SizedBox(
        width: imageSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImageViewSection(),
            SizedBox(height: imageTextSpacer),
            buildListingTitle(),
            SizedBox(height: textSpacer),
            buildListingRooms(),
            SizedBox(height: textSpacer),
            buildListingDistrict(),
            SizedBox(height: textSpacer),
            buildListingPrice()
          ],
        ),
      ),
    );
  }


  /// It builds the image view section in the card.
  Widget buildImageViewSection() {
    List<Widget> imageViews = [ ];
    bool isRTL = AppLocalizations.of(context)!.localeName == "ar";
    for (int i = 0; i < widget.listingModel.imagesUrls.length; i++) {
      imageViews.add(
        Stack(
          children: [
            Positioned.fill(
              left: (isRTL) ? null : widget.layoutConstraints.maxWidth - imageSize,
              right:  (isRTL) ? widget.layoutConstraints.maxWidth - imageSize : null,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(imageSize * 0.05),
                child: Image.network(
                  widget.listingModel.imagesUrls[i],
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.fill,
                ),
              ),
            )
          ],
        )
      );
    }

    return Hero(
      tag: "transition-home${widget.listingModel.listingId}-details",
      child: Container(
        height: imageSize,
        width: imageSize,
        alignment: Alignment.center,
        child: CarouselSlider(
          items: imageViews,
          options: CarouselOptions(
            onPageChanged: (int nextPage, CarouselPageChangedReason reason) {
              currImageIndex = nextPage;
            },
            viewportFraction: 1,
            height: imageSize,
          )
        )
      ),
    );
  }


  /// It builds the listing title text.
  Widget buildListingTitle() {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.layoutConstraints.maxWidth - imageSize ),
        child: Text(
          widget.listingModel.listingTitle,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Theme.of(context).textTheme.titleLarge!.fontSize
          ),
        ),
      ),
    );
  }


  /// It builds the listing rooms text.
  Widget buildListingRooms() {
    String bedroomText = (widget.listingModel.bedrooms == 1)
        ? "${AppLocalizations.of(context)!.bedroom} ${widget.listingModel.bedrooms}"
        : "${AppLocalizations.of(context)!.bedrooms} ${widget.listingModel.bedrooms}";
    String bathroomText = (widget.listingModel.bathrooms == 1)
        ? "${AppLocalizations.of(context)!.bathroom} ${widget.listingModel.bathrooms}"
        : "${AppLocalizations.of(context)!.bathrooms} ${widget.listingModel.bathrooms}";

    return FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.layoutConstraints.maxWidth - imageSize ),
        child: Text(
          "${bedroomText} / ${bathroomText}",
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).colorScheme.outlineVariant
          ),
        ),
      ),
    );
  }


  /// It builds the listing district text.
  Widget buildListingDistrict() {
    String districtText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.districtLabel} ${DistrictFormatter.mapEnumToText(context, widget.listingModel.district)}"
        : "${DistrictFormatter.mapEnumToText(context, widget.listingModel.district)} ${AppLocalizations.of(context)!.districtLabel}";
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.layoutConstraints.maxWidth - imageSize ),
        child: Text(
          districtText,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
            color: Theme.of(context).colorScheme.outlineVariant
          ),
        ),
      ),
    );
  }

  /// It builds the listing price text.
  Widget buildListingPrice() {
    String text = "${widget.listingModel.price} ${AppLocalizations.of(context)!.sar} ${AppLocalizations.of(context)!.monthly}";
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: widget.layoutConstraints.maxWidth - imageSize ),
        child: Text(
          text,
          overflow: TextOverflow.fade,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Theme.of(context).textTheme.titleSmall!.fontSize
          ),
        ),
      ),
    );
  }

}