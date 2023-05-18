import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/floor_enum.dart';

/// It maps FloorEnum to a text representation of app languages.
class FloorFormatter {

  /// It maps the given enum value to a translated text.
  static String mapEnumToText(BuildContext context, FloorEnum floorEnum) {
    switch (floorEnum) {
      case FloorEnum.roof:
        return AppLocalizations.of(context)!.roofFloor;
      case FloorEnum.ground:
        return AppLocalizations.of(context)!.groundFloor;
      case FloorEnum.first:
        return AppLocalizations.of(context)!.firstFloor;
      case FloorEnum.second:
        return AppLocalizations.of(context)!.secondFloor;
      case FloorEnum.third:
        return AppLocalizations.of(context)!.thirdFloor;
      default : //case FloorEnum.forth:
        return AppLocalizations.of(context)!.forthFloor;
    }
  }
}