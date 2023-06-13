
import 'dart:convert';

import 'package:vaea_mobile/data/enums/electrician_issue_category_enum.dart';
import 'package:vaea_mobile/data/enums/plumbing_issue_category_enum.dart';
import 'package:vaea_mobile/data/enums/room_name_eunm.dart';

/// It stores the fields that stores the body of rest api request that is sent
/// for submitting the electrician request.
class ElectricianDto {

  DateTime preferredAppointmentDate;
  RoomNameEnum selectedRoom;
  ElectricianIssueCategoryEnum selectedCategory;
  String description;
  /// optional
  String? notes;

  ElectricianDto({
    required this.preferredAppointmentDate,
    required this.selectedRoom,
    required this.selectedCategory,
    required this.description,
    this.notes
  });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "prefered_date": preferredAppointmentDate.toIso8601String(),
      "room": RoomNameEnumSerializer.serialize(selectedRoom),
      "category": ElectricianIssueCategoryEnumSerializer.serialize(selectedCategory),
      "describtion": description,
      "notes": notes
    };
  }


}