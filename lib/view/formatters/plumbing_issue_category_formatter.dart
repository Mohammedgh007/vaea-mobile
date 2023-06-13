import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/plumbing_issue_category_enum.dart';
import 'package:vaea_mobile/data/enums/room_name_eunm.dart';


/// It maps PlumbingIssueCategory to a translated text. Also, it provides a list of categories'
/// texts and enum values for submitting plumbing requests.
class PlumbingIssueCategoryFormatter {

  /// It maps the given category value to a translated text.
  static String mapEnumToText(BuildContext context, PlumbingIssueCategoryEnum category) {
    switch (category) {
      case PlumbingIssueCategoryEnum.sink:
        return AppLocalizations.of(context)!.sinkPlumbingCategory;
      case PlumbingIssueCategoryEnum.washer:
        return AppLocalizations.of(context)!.washerPlumbingCategory;
      case PlumbingIssueCategoryEnum.toilet:
        return AppLocalizations.of(context)!.toiletPlumbingCategory;
      case PlumbingIssueCategoryEnum.shower:
        return AppLocalizations.of(context)!.showerPlumbingCategory;
      case PlumbingIssueCategoryEnum.other:
        return AppLocalizations.of(context)!.otherPlumbingCategory;
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
      default: //case RoomNameEnum.other:
        return getOtherCategoriesList(context);
    }
  }


  /// It is a wrapper for all get...CategoriesVal. It uses the proper method based on
  /// the given room
  static List<PlumbingIssueCategoryEnum> getCategoriesVal(RoomNameEnum room) {
    switch(room) {
      case RoomNameEnum.kitchen:
        return getKitchenCategoriesVal();
      case RoomNameEnum.bathroom:
        return getBathroomCategoriesVal();
      default: //case RoomNameEnum.other:
        return getOtherCategoriesVal();
    }
  }


  /// It returns a list of bathroom categories' names as a translated text for a dropdown in plumbing form.
  static List<String> getBathroomCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.sinkPlumbingCategory,
      AppLocalizations.of(context)!.toiletPlumbingCategory,
      AppLocalizations.of(context)!.showerPlumbingCategory,
      AppLocalizations.of(context)!.otherPlumbingCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getBathroomCategoriesList.
  static List<PlumbingIssueCategoryEnum> getBathroomCategoriesVal() {
    return [
      PlumbingIssueCategoryEnum.sink,
      PlumbingIssueCategoryEnum.toilet,
      PlumbingIssueCategoryEnum.shower,
      PlumbingIssueCategoryEnum.other
    ];
  }


  /// It returns a list of kitchen categories' names as a translated text for a dropdown in plumbing form.
  static List<String> getKitchenCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.sinkPlumbingCategory,
      AppLocalizations.of(context)!.washerPlumbingCategory,
      AppLocalizations.of(context)!.otherPlumbingCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getBathroomCategoriesList.
  static List<PlumbingIssueCategoryEnum> getKitchenCategoriesVal() {
    return [
      PlumbingIssueCategoryEnum.sink,
      PlumbingIssueCategoryEnum.washer,
      PlumbingIssueCategoryEnum.other
    ];
  }


  /// It returns a list of kitchen categories' names as a translated text for a dropdown in plumbing form.
  static List<String> getOtherCategoriesList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.otherPlumbingCategory
    ];
  }


  /// It returns a list of enum values that is correspondent to the list of getBathroomCategoriesList.
  static List<PlumbingIssueCategoryEnum> getOtherCategoriesVal() {
    return [
      PlumbingIssueCategoryEnum.other
    ];
  }

}