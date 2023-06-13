import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/electrician_issue_category_enum.dart';
import 'package:vaea_mobile/data/enums/room_name_eunm.dart';

/// It maps ElectricianIssueCategoryFormatter to a translated text. Also, it provides a list of categories'
/// texts and enum values for submitting electrician requests.
class ElectricianIssueCategoryFormatter {

  /// It maps the given category value to a translated text.
  static String mapEnumToText(BuildContext context, ElectricianIssueCategoryEnum category) {
    switch (category) {
      case ElectricianIssueCategoryEnum.outlet:
        return AppLocalizations.of(context)!.outletElectricianCategory;
      case ElectricianIssueCategoryEnum.lamp:
        return AppLocalizations.of(context)!.lampElectricianCategory;
      case ElectricianIssueCategoryEnum.fanSuction:
        return AppLocalizations.of(context)!.fanSuctionElectricianCategory;
      case ElectricianIssueCategoryEnum.other:
        return AppLocalizations.of(context)!.otherElectricianCategory;
    }
  }


  /// It is a wrapper for all get..CategoriesList. It uses the proper method based on the
  /// given room.
  static List<String> getCategoriesList(BuildContext context, RoomNameEnum room) {
    switch(room) {
      case RoomNameEnum.kitchen:
        return getKitchenCategoriesList(context);
      case RoomNameEnum.bathroom:
        return getBathroomCategoriesList(context);
      case RoomNameEnum.bedroom:
        return getBedroomCategoriesList(context);
      case RoomNameEnum.livingRoom:
        return getLivingRoomCategoriesList(context);
      default: //case RoomNameEnum.other:
        return getOtherCategoriesList(context);
    }
  }


  /// It is a wrapper for all get...CategoriesVal. It uses the proper method based on
  /// the given room
  static List<ElectricianIssueCategoryEnum> getCategoriesVal(RoomNameEnum room) {
    switch(room) {
      case RoomNameEnum.kitchen:
        return getKitchenCategoriesVal();
      case RoomNameEnum.bathroom:
        return getBathroomCategoriesVal();
      case RoomNameEnum.bedroom:
        return getBathroomCategoriesVal();
      case RoomNameEnum.livingRoom:
        return getBathroomCategoriesVal();
      default: //case RoomNameEnum.other:
        return getOtherCategoriesVal();
    }
  }


  /// It returns a list of bathroom categories' names as a translated text for a dropdown in electricity form.
  static List<String> getBathroomCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.outletElectricianCategory,
      AppLocalizations.of(context)!.lampElectricianCategory,
      AppLocalizations.of(context)!.fanSuctionElectricianCategory,
      AppLocalizations.of(context)!.otherElectricianCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getBathroomCategoriesList.
  static List<ElectricianIssueCategoryEnum> getBathroomCategoriesVal() {
    return [
      ElectricianIssueCategoryEnum.outlet,
      ElectricianIssueCategoryEnum.lamp,
      ElectricianIssueCategoryEnum.fanSuction,
      ElectricianIssueCategoryEnum.other
    ];
  }


  /// It returns a list of kitchen categories' names as a translated text for a dropdown in electricity form.
  static List<String> getKitchenCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.outletElectricianCategory,
      AppLocalizations.of(context)!.lampElectricianCategory,
      AppLocalizations.of(context)!.fanSuctionElectricianCategory,
      AppLocalizations.of(context)!.otherElectricianCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getKitchenCategoriesList.
  static List<ElectricianIssueCategoryEnum> getKitchenCategoriesVal() {
    return [
      ElectricianIssueCategoryEnum.outlet,
      ElectricianIssueCategoryEnum.lamp,
      ElectricianIssueCategoryEnum.fanSuction,
      ElectricianIssueCategoryEnum.other
    ];
  }


  /// It returns a list of bedroom categories' names as a translated text for a dropdown in electricity form.
  static List<String> getBedroomCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.outletElectricianCategory,
      AppLocalizations.of(context)!.lampElectricianCategory,
      AppLocalizations.of(context)!.otherElectricianCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getBedroomCategoriesList.
  static List<ElectricianIssueCategoryEnum> getBedroomCategoriesVal() {
    return [
      ElectricianIssueCategoryEnum.outlet,
      ElectricianIssueCategoryEnum.lamp,
      ElectricianIssueCategoryEnum.other
    ];
  }


  /// It returns a list of living room categories' names as a translated text for a dropdown in electricity form.
  static List<String> getLivingRoomCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.outletElectricianCategory,
      AppLocalizations.of(context)!.lampElectricianCategory,
      AppLocalizations.of(context)!.otherElectricianCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getLivingRoomCategoriesList.
  static List<ElectricianIssueCategoryEnum> getLivingRoomCategoriesVal() {
    return [
      ElectricianIssueCategoryEnum.outlet,
      ElectricianIssueCategoryEnum.lamp,
      ElectricianIssueCategoryEnum.other
    ];
  }


  /// It returns a list of other categories' names as a translated text for a dropdown in electricity form.
  static List<String> getOtherCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.otherElectricianCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getOtherCategoriesList.
  static List<ElectricianIssueCategoryEnum> getOtherCategoriesVal() {
    return [
      ElectricianIssueCategoryEnum.other
    ];
  }


}