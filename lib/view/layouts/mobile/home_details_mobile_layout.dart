import 'dart:async';

import 'package:breakpoint/breakpoint.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:vaea_mobile/view/formatters/floor_formatter.dart';
import 'package:vaea_mobile/view/formatters/home_type_formatter.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';
import 'package:vaea_mobile/view/widgets/containers/images_view_container.dart';
import 'package:vaea_mobile/view/widgets/icons/amenity_icon.dart';

import '../../../data/enums/home_type.dart';
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

  HomeDetailsMobileLayout(
      {super.key,
      required this.isLoading,
      required this.detailsModel,
      required this.listingId,
      required this.sliderImageIndex,
      required this.sliderImages,
      required this.handleClickBook});

  @override
  State<HomeDetailsMobileLayout> createState() =>
      _HomeDetailsHomeDetailsMobileLayout();
}

class _HomeDetailsHomeDetailsMobileLayout
    extends State<HomeDetailsMobileLayout> {
  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  // dimensions
  late double sectionsSpacer;
  late double sectionContainerWidth;
  late double sectionContainerPadding;
  late double containerRowsSpacer;

  late double imageSize;
  late double horizontalPadding;
  late double mapViewHeight;
  late double titleSpacer;
  late double bodyTextSpacer;

  /// It is a helper method for build(). It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      sectionContainerWidth = layoutConstraints.maxWidth * 0.92;
      sectionContainerPadding = layoutConstraints.maxWidth * 0.04;
      containerRowsSpacer = layoutConstraints.maxHeight * 0.01;

      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else if (breakpoint.device.name == "mediumHandset") {
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      sectionContainerWidth = layoutConstraints.maxWidth * 0.92;
      sectionContainerPadding = layoutConstraints.maxWidth * 0.04;
      containerRowsSpacer = layoutConstraints.maxHeight * 0.01;

      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else {
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      sectionContainerWidth = layoutConstraints.maxWidth * 0.92;
      sectionContainerPadding = layoutConstraints.maxWidth * 0.04;
      containerRowsSpacer = layoutConstraints.maxHeight * 0.01;

      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      breakpoint = Breakpoint.fromConstraints(constraints);
      layoutConstraints = constraints;
      setupDimensions();

      return Scaffold(
        appBar: AdaptiveTopAppBar(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            previousPageTitle: AppLocalizations.of(context)!.homeSearch,
            currPageTitle: AppLocalizations.of(context)!.homeDetails),
        body: SizedBox(
          width: layoutConstraints.maxWidth,
          height: layoutConstraints.maxHeight,
          child: ListView(
            // 90 is the default fab height and padding
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewPadding.bottom + 90),
            children: [
              buildImageSection(),
              SizedBox(height: sectionsSpacer),
              if (widget.isLoading) const CircularProgressIndicator.adaptive(),
              if (!widget.isLoading) buildListingInfoSection(),
              if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              if (!widget.isLoading) buildUnitDetailsSection(),
              if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              if (!widget.isLoading) buildLocationSection(),
              if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              // if (!widget.isLoading) buildTitleSection(),
              // if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              // if (!widget.isLoading) buildLocationSection(),
              // if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              // if (!widget.isLoading) buildApartmentDetails(),
              // if (!widget.isLoading) SizedBox(height: sectionsSpacer),
              // if (!widget.isLoading) buildFacilitiesSection()
            ],
          ),
        ),
        floatingActionButton: PrimaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: widget.handleClickBook,
            buttonText: AppLocalizations.of(context)!.book),
      );
    });
  }

  /// It builds the image section of the layout.
  Widget buildImageSection() {
    return ImagesViewContainer(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        imageUrls: widget.sliderImages);
  }

  /// It is a helper method that builds the container decoration for the sections.
  BoxDecoration getContainerDecoration() {
    return BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(sectionContainerWidth * 0.05),
        border: Border.all(
            width: 0.1, color: const Color.fromRGBO(151, 151, 151, 1)),
        boxShadow: const [
          BoxShadow(
              blurRadius: 40,
              offset: Offset(0, 4),
              color: Color.fromRGBO(0, 0, 0, 0.05))
        ]);
  }

  /// It is a helper method that builds a section title text.
  Widget buildSectionTitle(String titleStr) {
    return Text(
      titleStr,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
          fontWeight: FontWeight.normal),
    );
  }

  /// It builds the listing info section.
  Widget buildListingInfoSection() {
    return Container(
      width: sectionContainerWidth,
      decoration: getContainerDecoration(),
      padding: EdgeInsets.all(sectionContainerPadding),
      margin: EdgeInsets.symmetric(
          horizontal: (layoutConstraints.maxWidth - sectionContainerWidth) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle(AppLocalizations.of(context)!.listingDetails),
          SizedBox(height: containerRowsSpacer),
          buildListingTitleRow(),
          SizedBox(height: containerRowsSpacer),
          buildHomeTypeRow(),
          SizedBox(height: containerRowsSpacer),
          buildListingIDRow(),
          SizedBox(height: containerRowsSpacer),
          buildPriceRow()
        ],
      ),
    );
  }

  /// It is a helper method for buildListingInfoSection. It builds the listing title.
  Widget buildListingTitleRow() {
    return Text(
      widget.detailsModel!.listingTitle,
      style: TextStyle(
          fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
          fontWeight: FontWeight.bold),
    );
  }

  /// It is a helper method for buildListingInfoSection. It builds the home type row.
  Widget buildHomeTypeRow() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.maps_home_work_outlined,
              size: sectionContainerWidth * 0.04,
              color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(width: 8),
          Text(
            HomeTypeFormatter.mapEnumToText(
                context, widget.detailsModel!.listingType),
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.outlineVariant),
          )
        ],
      ),
    );
  }

  /// It is a helper method for buildListingInfoSection. It builds the home type row.
  Widget buildListingIDRow() {
    String outputString =
        "${AppLocalizations.of(context)!.listingIdIs} ${widget.detailsModel!.listingId}";

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.bookmark_border_rounded,
              size: sectionContainerWidth * 0.04,
              color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(width: 8),
          Text(
            outputString,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.outlineVariant),
          )
        ],
      ),
    );
  }

  /// It is a helper method for buildListingInfoSection. It builds the price row.
  Widget buildPriceRow() {
    String outputStr = (widget.detailsModel!.listingType == HomeType.private)
        ? "${widget.detailsModel!.price} ${AppLocalizations.of(context)!.sar}/ ${AppLocalizations.of(context)!.unit}"
        : "${widget.detailsModel!.price} ${AppLocalizations.of(context)!.sar} / ${AppLocalizations.of(context)!.roomUnitCard}";

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.monetization_on_outlined,
              size: sectionContainerWidth * 0.04,
              color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Text(
            outputStr,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.secondary),
          )
        ],
      ),
    );
  }

  /// It builds the section of unit details
  Widget buildUnitDetailsSection() {
    return Container(
      width: sectionContainerWidth,
      decoration: getContainerDecoration(),
      padding: EdgeInsets.all(sectionContainerPadding),
      margin: EdgeInsets.symmetric(
          horizontal: (layoutConstraints.maxWidth - sectionContainerWidth) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle(AppLocalizations.of(context)!.unitFeatures),
          SizedBox(height: containerRowsSpacer),
          buildGeneralInfoRow(),
          SizedBox(height: containerRowsSpacer * 2),
          buildAmenityIconFirstRow(),
          SizedBox(height: containerRowsSpacer * 2),
          buildAmenityIconSecondRow(),
          SizedBox(height: containerRowsSpacer * 2),
          buildAmenityIconThirdRow(),
        ],
      ),
    );
  }

  /// It is a helper method for buildUnitDetailsSection. It builds the first row
  /// below the title. It specifies the availability, area, and floor.
  Widget buildGeneralInfoRow() {
    String availabilityText = (widget.detailsModel!.unitMaxCapacity == 1)
        ? AppLocalizations.of(context)!.wholeUnit
        : "${widget.detailsModel!.unitAvailableCapacity} / ${widget.detailsModel!.unitMaxCapacity}";
    String areaText =
        "${widget.detailsModel!.area} ${AppLocalizations.of(context)!.mUnit}";
    String floorText =
        FloorFormatter.mapEnumToText(context, widget.detailsModel!.floor);

    TextStyle labelStyle = TextStyle(
        fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
        color: Theme.of(context).colorScheme.outlineVariant);
    TextStyle subLabelStyle = TextStyle(
        fontSize: Theme.of(context).textTheme.labelMedium!.fontSize,
        color: Theme.of(context).colorScheme.secondary);

    Widget availabilityColumn = Column(
      children: [
        Text(AppLocalizations.of(context)!.availability, style: labelStyle),
        Text(availabilityText, style: subLabelStyle)
      ],
    );
    Widget areaColumn = Column(
      children: [
        Text(AppLocalizations.of(context)!.area, style: labelStyle),
        Text(areaText, style: subLabelStyle)
      ],
    );
    Widget floorColumn = Column(
      children: [
        Text(AppLocalizations.of(context)!.floor, style: labelStyle),
        Text(floorText, style: subLabelStyle)
      ],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: availabilityColumn),
        Expanded(child: areaColumn),
        Expanded(child: floorColumn)
      ],
    );
  }

  /// It is a helper method for buildUnitDetailsSection. It builds the first row of
  /// amenities icons.
  Widget buildAmenityIconFirstRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.electricity)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.water)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.internet)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.parking)),
      ],
    );
  }

  /// It is a helper method for buildUnitDetailsSection. It builds the second row of
  /// amenities icons.
  Widget buildAmenityIconSecondRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.equippedKitchen)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.privateBathroom)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.furnishedBedroom)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.security)),
      ],
    );
  }

  /// It is a helper method for buildUnitDetailsSection. It builds the third row of
  /// amenities icons.
  Widget buildAmenityIconThirdRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.tv)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.ac)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.washer)),
        Expanded(
            child: AmenityIcon(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                amenityIconType: AmenityIconType.waterHeater)),
      ],
    );
  }

  /// It builds the address section
  Widget buildLocationSection() {
    return Container(
      width: sectionContainerWidth,
      decoration: getContainerDecoration(),
      padding: EdgeInsets.all(sectionContainerPadding),
      margin: EdgeInsets.symmetric(
          horizontal: (layoutConstraints.maxWidth - sectionContainerWidth) / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionTitle(AppLocalizations.of(context)!.location),
          SizedBox(height: containerRowsSpacer),
          buildDistrictRow(),
          SizedBox(height: containerRowsSpacer),
          buildStreetRow(),
          SizedBox(height: containerRowsSpacer),
          buildBuildingNumberRow(),
          SizedBox(height: containerRowsSpacer * 2),
          AppGoogleMapView(
            position:
                LatLng(widget.detailsModel!.lat, widget.detailsModel!.lon),
            imageSize: imageSize,
            mapViewHeight: mapViewHeight,
          )
        ],
      ),
    );
  }

  /// It builds the district row for buildAddressSection.
  Widget buildDistrictRow() {
    String districtText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.districtLabel} ${DistrictFormatter.mapEnumToText(context, widget.detailsModel!.district)}"
        : "${DistrictFormatter.mapEnumToText(context, widget.detailsModel!.district)} ${AppLocalizations.of(context)!.districtLabel}";

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.area_chart_outlined,
              size: sectionContainerWidth * 0.04,
              color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(width: 8),
          Text(
            districtText,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.outlineVariant),
          )
        ],
      ),
    );
  }

  /// It builds the street row for buildAddressSection.
  Widget buildStreetRow() {
    String streetText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.street} ${widget.detailsModel!.street}"
        : "${widget.detailsModel!.street} ${AppLocalizations.of(context)!.street}";

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.edit_road_outlined,
              size: sectionContainerWidth * 0.04,
              color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(width: 8),
          Text(
            streetText,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.outlineVariant),
          )
        ],
      ),
    );
  }

  /// It builds the building number row for buildAddressSection.
  Widget buildBuildingNumberRow() {
    String buildingNumberText =
        "${AppLocalizations.of(context)!.building} ${widget.detailsModel!.buildingId}";

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.house_siding_outlined,
              size: sectionContainerWidth * 0.04,
              color: Theme.of(context).colorScheme.outlineVariant),
          const SizedBox(width: 8),
          Text(
            buildingNumberText,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.outlineVariant),
          )
        ],
      ),
    );
  }
}

class AppGoogleMapView extends StatelessWidget {
  final double imageSize;
  final double mapViewHeight;
  final LatLng position;
  const AppGoogleMapView(
      {super.key,
      required this.imageSize,
      required this.mapViewHeight,
      required this.position});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: imageSize,
      height: mapViewHeight,
      child: GoogleMap(
          onTap: (_) => MapsLauncher.launchCoordinates(
              position.latitude, position.longitude),
          mapType: MapType.normal,
          markers: {
            Marker(markerId: const MarkerId("market"), position: position)
          },
          initialCameraPosition: CameraPosition(zoom: 15.0, target: position)),
    );
  }
}
