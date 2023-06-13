import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:vaea_mobile/data/enums/service_type_enum.dart';

/// It provides the UI representation for the service type that includes image path,
/// title, and description.
class ServiceTypeFormatter {

  /// It returns the image path correspondent to each service type.
  static String getImagePath(ServiceTypeEnum serviceType) {
    switch (serviceType) {
      case ServiceTypeEnum.cleaning:
        return "assets/images/house_cleaning_service.png";
      case ServiceTypeEnum.plumber:
        return "assets/images/plumbing_service.png";
      default: // case ServiceTypeEnum.electrician:
        return "assets/images/electrician_service.png";
    }
  }


  /// It returns the string title that represent the service type.
  static String getTitle(ServiceTypeEnum serviceType, BuildContext context) {
    switch (serviceType) {
      case ServiceTypeEnum.cleaning:
        return AppLocalizations.of(context)!.houseCleaning;
      case ServiceTypeEnum.plumber:
        return AppLocalizations.of(context)!.plumbing;
      default: // case ServiceTypeEnum.electrician:
        return AppLocalizations.of(context)!.electrician;
    }
  }


  /// It returns the string description that represent the service type.
  static String getDescription(ServiceTypeEnum serviceType, BuildContext context) {
    switch (serviceType) {
      case ServiceTypeEnum.cleaning:
        return AppLocalizations.of(context)!.houseCleaningDisc;
      case ServiceTypeEnum.plumber:
        return AppLocalizations.of(context)!.plumbingDisc;
      default: // case ServiceTypeEnum.electrician:
        return AppLocalizations.of(context)!.electricianDisc;
    }
  }
}