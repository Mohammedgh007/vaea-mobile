
import 'dart:async';

import 'package:breakpoint/breakpoint.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:vaea_mobile/view/formatters/floor_formatter.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';

import '../../../data/model/home_details_model.dart';
import '../../formatters/district_formatter.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';

/// It handles the ui interaction for HomeDetailsScreen
class HomeDetailsMobileLayout extends StatefulWidget {

  bool isLoading;
  HomeDetailsModel? detailsModel;
  int listingId; // it is used for hero animation
  int sliderImageIndex; // It is used for hero animation
  List<String> sliderImages; // It is used for hero animation.
  Future<void> Function() handleClickBook;

  HomeDetailsMobileLayout({
    super.key,
    required this.isLoading,
    required this.detailsModel,
    required this.listingId,
    required this.sliderImageIndex,
    required this.sliderImages,
    required this.handleClickBook
  });


  @override
  State<HomeDetailsMobileLayout> createState() => _HomeDetailsHomeDetailsMobileLayout();
}

class _HomeDetailsHomeDetailsMobileLayout extends State<HomeDetailsMobileLayout> {


  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  // dimensions
  late double imageSize;
  late double horizontalPadding;
  late double mapViewHeight;
  late double sectionsSpacer;
  late double titleSpacer;
  late double bodyTextSpacer;


  /// It is a helper method for build(). It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      sectionsSpacer = layoutConstraints.maxHeight * 0.038;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else {
      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      breakpoint = Breakpoint.fromConstraints(constraints);
      layoutConstraints = constraints;
      setupDimensions();

      return Scaffold(
        appBar: AdaptiveTopAppBar(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            previousPageTitle: AppLocalizations.of(context)!.homeSearch,
            currPageTitle: AppLocalizations.of(context)!.homeDetails
        ),
        body: SizedBox(
          width: layoutConstraints.maxWidth,
          height: layoutConstraints.maxHeight,
          child: ListView( // 90 is the default fab height and padding
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 90),
            children: [
              buildImageSection(),
              if (widget.isLoading) const CircularProgressIndicator.adaptive(),
              if (!widget.isLoading) buildTitleSection(),
              if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              if (!widget.isLoading) buildLocationSection(),
              if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              if (!widget.isLoading) buildApartmentDetails(),
              if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              if (!widget.isLoading) buildFacilitiesSection()
            ],
          ),
        ),
        floatingActionButton: PrimaryBtn(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          handleClick: widget.handleClickBook,
          buttonText: AppLocalizations.of(context)!.book
        ),
      );
    });
  }


  /// It builds the image section of the layoyt.
  Widget buildImageSection() {
    List<Widget> imageViews = [ ];
    for (int i = 0; i < widget.sliderImages.length; i++) {
      imageViews.add(
          Stack(
            children: [
              Positioned.fill(
                left: (layoutConstraints.maxWidth - imageSize) ,
                //right: (widget.layoutConstraints.maxWidth - imageSize) / 2,
                child: Image.network(
                  widget.sliderImages[i],
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.fill,
                ),
              )
            ],
          )
      );
    }

    return Hero(
      tag: "transition-home${widget.listingId}-details",
      child: Container(
          height: imageSize,
          width: imageSize,
          alignment: Alignment.center,
          child: CarouselSlider(
              items: imageViews,
              options: CarouselOptions(
                initialPage: widget.sliderImageIndex,
                viewportFraction: 1,
                height: imageSize,
              )
          )
      ),
    );
  }


  /// It builds the title section.
  Widget buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding ),
      child: Text(
        widget.detailsModel!.listingTitle,
        overflow: TextOverflow.fade,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize
        ),
      ),
    );
  }


  /// It builds the location section.
  Widget buildLocationSection() {
    String districtText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.districtLabel} ${DistrictFormatter.mapEnumToText(context, widget.detailsModel!.district)}"
        : "${DistrictFormatter.mapEnumToText(context, widget.detailsModel!.district)} ${AppLocalizations.of(context)!.districtLabel}";
    String streetText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.street} ${widget.detailsModel!.street}"
        : "${widget.detailsModel!.street} ${AppLocalizations.of(context)!.street}";
    String buildText = "${AppLocalizations.of(context)!.building} ${widget.detailsModel!.buildingId}";
    
    return buildTextSection(
        AppLocalizations.of(context)!.location,
        [ districtText, streetText, buildText ],
        buildGoogleMapView()
    );
  }


  /// It is a helper method for buildLocationSection.
  Widget buildGoogleMapView() {
    LatLng position = LatLng(widget.detailsModel!.lat, widget.detailsModel!.lon);
    return SizedBox(
      width: imageSize,
      height: mapViewHeight,
      child: GoogleMap(
        onTap: (_) => MapsLauncher.launchCoordinates(position.latitude, position.longitude),
        mapType: MapType.normal,
        markers: {Marker(markerId: MarkerId("market"), position: position)},
        initialCameraPosition: CameraPosition(
          zoom: 15.0,
          target: position
        )
      ),
    );//dotenv.env["GOOGLE_MAP_KEY"];
  }


  /// it builds the apartment details section
  Widget buildApartmentDetails() {
    String bedroomText = (widget.detailsModel!.bedrooms == 1)
        ? "${AppLocalizations.of(context)!.bedroom} ${widget.detailsModel!.bedrooms}"
        : "${AppLocalizations.of(context)!.bedrooms} ${widget.detailsModel!.bedrooms}";
    String bathroomText = (widget.detailsModel!.bathrooms == 1)
        ? "${AppLocalizations.of(context)!.bathroom} ${widget.detailsModel!.bathrooms}"
        : "${AppLocalizations.of(context)!.bathrooms} ${widget.detailsModel!.bathrooms}";
    String roomText = "${bedroomText} / ${bathroomText}";
    String areaText = "${widget.detailsModel!.area} ${AppLocalizations.of(context)!.mUnit}";
    String floorText = FloorFormatter.mapEnumToText(context, widget.detailsModel!.floor);

    return buildTextSection(
        AppLocalizations.of(context)!.unitDetails,
        [ roomText, areaText, floorText ],
        null
    );
  }


  /// It builds the facilities section
  Widget buildFacilitiesSection() {
    return buildTextSection(
        AppLocalizations.of(context)!.facilities,
        [
          AppLocalizations.of(context)!.fullyFurnished,
          AppLocalizations.of(context)!.fullyEquippedKitchen,
          AppLocalizations.of(context)!.reservedParkingLot
        ],
        null
    );
  }


  /// It is a helper method. It builds a section title with its info.
  Widget buildTextSection(String title, List<String> lines, Widget? map) {
    List<Widget> spacedLines = [
      Text(
        title,
        style: TextStyle(
          fontSize: Theme.of(context)!.textTheme.headlineMedium!.fontSize
        ),
      ),
      SizedBox(height: titleSpacer)
    ];


    for (int i = 0; i < lines.length; i++) {
      spacedLines.add( Text(
          lines[i],
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
          ),
      ));

      if (i + 1 < lines.length)
        spacedLines.add(SizedBox(height: bodyTextSpacer));

    }

    if (map != null) {
      spacedLines.add(SizedBox(height: bodyTextSpacer * 2));
      spacedLines.add(map);
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: spacedLines,
      ),
    );
  }

}