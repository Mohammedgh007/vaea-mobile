
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';

/// It maps DistrictEnum to a text representation in app languages.
class DistrictFormatter {

  /// It maps the given enum value to a translated text.
  static String mapEnumToText(BuildContext context, DistrictEnum val) {
    switch(val) {
      case DistrictEnum.aqiqRuh:
        return AppLocalizations.of(context)!.aqiq;
      default:
        return AppLocalizations.of(context)!.malqa;
    }
  }
}