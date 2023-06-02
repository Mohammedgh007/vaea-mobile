
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// It maps HomeType enum to a translated text.
class HomeTypeFormatter {

  /// It maps the given enum value to a translated text.
  static String mapEnumToText(BuildContext context, HomeType val) {
    switch(val) {
      case HomeType.shared:
        return AppLocalizations.of(context)!.sharedHomeTitle;
      default: // HomeType.private
        return AppLocalizations.of(context)!.entireHomeTitle;
    }
  }
}