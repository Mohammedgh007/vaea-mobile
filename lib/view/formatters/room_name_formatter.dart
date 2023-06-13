import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/room_name_eunm.dart';


/// It maps RoomNameEnum to a translated text. Also, it provides a list of rooms'
/// texts and enum values for submitting services' requests.
class RoomNameFormatter {

  /// It maps the given enum value to a translated text.
  static String mapEnumToText(BuildContext context, RoomNameEnum roomName) {
    switch (roomName) {
      case RoomNameEnum.kitchen:
        return AppLocalizations.of(context)!.kitchenRoomName;
      case RoomNameEnum.bathroom:
        return AppLocalizations.of(context)!.bathroomRoomName;
      case RoomNameEnum.bedroom:
        return AppLocalizations.of(context)!.bedroomRoomName;
      case RoomNameEnum.livingRoom:
        return AppLocalizations.of(context)!.livingRoomName;
      case RoomNameEnum.other:
        return AppLocalizations.of(context)!.otherRoomName;
    }
  }


  /// It returns a list of room names as a translated text for a dropdown in plumbing form.
  static List<String> getPlumbingRoomsList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.kitchenRoomName,
      AppLocalizations.of(context)!.bathroomRoomName,
      AppLocalizations.of(context)!.otherRoomName
    ];
  }

  /// It returns a list of enum values that is correspondent to the list of getPlumbingRoomsList.
  static List<RoomNameEnum> getPlumbingRoomsVal() {
    return [
      RoomNameEnum.kitchen,
      RoomNameEnum.bathroom,
      RoomNameEnum.other
    ];
  }


  /// It returns a list of room names as a translated text for a dropdown in plumbing form.
  static List<String> getElectricianRoomsList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.kitchenRoomName,
      AppLocalizations.of(context)!.bathroomRoomName,
      AppLocalizations.of(context)!.bedroomRoomName,
      AppLocalizations.of(context)!.livingRoomName,
      AppLocalizations.of(context)!.otherRoomName
    ];
  }

  /// It returns a list of enum values that is correspondent to the list of getPlumbingRoomsList.
  static List<RoomNameEnum> getElectricianRoomsVal() {
    return [
      RoomNameEnum.kitchen,
      RoomNameEnum.bathroom,
      RoomNameEnum.bedroom,
      RoomNameEnum.livingRoom,
      RoomNameEnum.other
    ];
  }


}