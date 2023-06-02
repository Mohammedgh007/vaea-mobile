
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AmenityIcon extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  AmenityIconType amenityIconType;

  // dimensions
  late double whiteIconContainerSize;
  late double whiteIconContainerPadding;
  late double containerTextSpacer;

  AmenityIcon({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.amenityIconType
  }){
    setupDimensions();
  }

  /// It is a helper method for the constructor. It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      whiteIconContainerSize = layoutConstraints.maxWidth * 0.128;
      whiteIconContainerPadding = whiteIconContainerSize * 0.27;
    } else if (breakpoint.device.name == "mediumHandset") {
      whiteIconContainerSize = layoutConstraints.maxWidth * 0.128;
      whiteIconContainerPadding = whiteIconContainerSize * 0.27;
    } else {
      whiteIconContainerSize = layoutConstraints.maxWidth * 0.128;
      whiteIconContainerPadding = whiteIconContainerSize * 0.27;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        buildIconSection(context),
        buildAmenityText(context)
      ],
    );
  }


  /// It builds the white container with the amenity icon.
  Widget buildIconSection(BuildContext context) {
    return Container(
      width: whiteIconContainerSize,
      height: whiteIconContainerSize,
      decoration: getWhiteContainerDecoration(context),
      padding: EdgeInsets.all(whiteIconContainerPadding),
      child: getAmenityIcon(),
    );
  }

  /// It is a helper method that builds the white container decoration for buildIconSection.
  BoxDecoration getWhiteContainerDecoration(BuildContext context) {
    return BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(whiteIconContainerSize * 0.2),
        border: Border.all(width: 0.1, color: const Color.fromRGBO(151, 151, 151, 1)),
        boxShadow: const [BoxShadow(blurRadius: 40, offset: Offset(0, 4), color: Color.fromRGBO(0, 0, 0, 0.05))]
    );
  }


  /// It is a helper method for buildIconSection. It builds the inner amenity icon.
  Widget getAmenityIcon() {
    switch(amenityIconType) {
      case AmenityIconType.electricity:
        return SvgPicture.asset( "assets/logos/amenity_logos/electricity_amenity.svg");
      case AmenityIconType.water:
        return SvgPicture.asset( "assets/logos/amenity_logos/water_amenity.svg");
      case AmenityIconType.internet:
        return SvgPicture.asset( "assets/logos/amenity_logos/internet_amenity.svg");
      case AmenityIconType.parking:
        return SvgPicture.asset( "assets/logos/amenity_logos/parking_amenity.svg");
      case AmenityIconType.equippedKitchen:
        return SvgPicture.asset( "assets/logos/amenity_logos/equipped_kitchen_amenity.svg");
      case AmenityIconType.privateBathroom:
        return SvgPicture.asset( "assets/logos/amenity_logos/private_bathroom_amenity.svg");
      case AmenityIconType.furnishedBedroom:
        return SvgPicture.asset( "assets/logos/amenity_logos/furnished_bedroom_amenity.svg");
      case AmenityIconType.security:
        return SvgPicture.asset( "assets/logos/amenity_logos/security_amenity.svg");
      case AmenityIconType.tv:
        return SvgPicture.asset( "assets/logos/amenity_logos/tv_amenity.svg");
      case AmenityIconType.ac:
        return SvgPicture.asset( "assets/logos/amenity_logos/ac_amenity.svg");
      case AmenityIconType.washer:
        return SvgPicture.asset( "assets/logos/amenity_logos/washer_amenity.svg");
      default: //case AmenityIconType.waterHeater:
        return SvgPicture.asset( "assets/logos/amenity_logos/water_heater_amenity.svg");
    }

  }


  /// It builds the amenity name below the white container
  Widget buildAmenityText(BuildContext context) {
    return Text(
      getAmenityTranslatedStr(context),
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
        color: Theme.of(context).colorScheme.onBackground
      ),
    );
  }


  /// It is a helper method for buildAmenityText. It returns the amenity text translation.
  String getAmenityTranslatedStr(BuildContext context) {
    switch(amenityIconType) {
      case AmenityIconType.electricity:
        return AppLocalizations.of(context)!.electricityAmenity;
      case AmenityIconType.water:
        return AppLocalizations.of(context)!.waterAmenity;
      case AmenityIconType.internet:
        return AppLocalizations.of(context)!.internetAmenity;
      case AmenityIconType.parking:
        return AppLocalizations.of(context)!.parkingAmenity;
      case AmenityIconType.equippedKitchen:
        return AppLocalizations.of(context)!.equippedKitchenAmenity;
      case AmenityIconType.privateBathroom:
        return AppLocalizations.of(context)!.privateBathroomAmenity;
      case AmenityIconType.furnishedBedroom:
        return AppLocalizations.of(context)!.furnishedBedroomAmenity;
      case AmenityIconType.security:
        return AppLocalizations.of(context)!.securityAmenity;
      case AmenityIconType.tv:
        return AppLocalizations.of(context)!.tvAmenity;
      case AmenityIconType.ac:
        return AppLocalizations.of(context)!.acAmenity;
      case AmenityIconType.washer:
        return AppLocalizations.of(context)!.washerAmenity;
      default: //case AmenityIconType.waterHeater:
        return AppLocalizations.of(context)!.waterHeaterAmenity;
    }

  }

}


/// It specifies the amenity type for specifying the target icon.
enum AmenityIconType {
  electricity,
  water,
  internet,
  parking,

  equippedKitchen,
  privateBathroom,
  furnishedBedroom,
  security,

  tv,
  ac,
  washer,
  waterHeater,
}