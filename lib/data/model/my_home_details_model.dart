
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';
import 'package:vaea_mobile/data/enums/floor_enum.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';

/// It represents the properties of the user home details info.
class MyHomeDetailsModel {

  late List<String> unitImages;
  late DateTime moveIn;
  late DateTime moveOut;
  late String unitName;
  late double lat;
  late double lon;
  late List<MyHomeDetailsModelRoommate>? roommates;


  /// It constructs the instance based on the decoded map from the search result.
  MyHomeDetailsModel.fromMap(Map<String, dynamic> decodedMap) {
    unitImages = List<String>.from( decodedMap["unit_images"] as List);
    moveIn = DateTime.parse(decodedMap["move_in"]);
    moveOut = DateTime.parse(decodedMap["move_out"]);
    unitName = decodedMap["unit_name"];
    lat = decodedMap["lat"];
    lon = decodedMap["lon"];
    debugPrint("kkkk ${decodedMap["roommates"]}");
    if (decodedMap["roommates"] != null && (decodedMap["roommates"] as List<dynamic>).isNotEmpty) {
      roommates = (decodedMap["roommates"] as List<dynamic>).map((e) => MyHomeDetailsModelRoommate.fromMap(e)).toList();
    }
  }

  MyHomeDetailsModel({
    required this.unitName, required this.moveIn, required this.moveOut,
    required this.unitImages, required this.roommates,
    required this.lon, required this.lat
  });


}

class MyHomeDetailsModelRoommate {

  late String firstName;
  late String lastname;
  late String unitName;
  late String? roommateImage;

  MyHomeDetailsModelRoommate({
    required this.firstName, required this.lastname, required this.unitName, required this.roommateImage
  });

  /// It constructs the instance based on the decoded map from the search result.
  MyHomeDetailsModelRoommate.fromMap(Map<String, dynamic> decodedMap) {
    debugPrint("in from $decodedMap");
    firstName = decodedMap["first_name"];
    lastname = decodedMap["last_name"];
    unitName = decodedMap["unit_name"];
    roommateImage = decodedMap["roommate_image"];
  }
}
