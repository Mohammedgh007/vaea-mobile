
import 'dart:convert';

import 'package:flutter/material.dart';

/// It stores the fields that stores the body of rest api request that is sent
/// for submitting the house cleaning request.
class HouseCleaningDto {

  DateTime preferredAppointmentDate;
  /// optional
  String? notes;

  HouseCleaningDto({
    required this.preferredAppointmentDate,
    this.notes
  });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {

    return {
      "prefered_date": preferredAppointmentDate.toIso8601String(),
      "notes": notes
    };
  }


}