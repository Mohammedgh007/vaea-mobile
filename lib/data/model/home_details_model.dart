
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';
import 'package:vaea_mobile/data/enums/floor_enum.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';

import '../enums/gender.dart';

/// It represents the properties of the home details info.
class HomeDetailsModel {

  late int listingId;
  late int buildingId;
  late HomeType listingType;
  late DistrictEnum district;
  late String street;
  late Gender gender;
  late double lat;
  late double lon;
  late int bedrooms;
  late int bathrooms;
  late int unitMaxCapacity;
  late int unitAvailableCapacity;
  late int area;
  late FloorEnum floor;
  late List<String> imagesUrls;
  late String listingTitle;
  late int price;

  /// It constructs the instance based on the decoded map from the search result.
  HomeDetailsModel.fromMap(Map<String, dynamic> decodedMap) {
    listingId = decodedMap["unit_id"];
    buildingId = decodedMap["building_id"];
    listingType = HomeTypeParser.parse(decodedMap["unit_type"]);
    district = DistrictEnumParser.parse(decodedMap["district"]);
    street = decodedMap["street"];
    gender = GenderParser.parse(decodedMap["gender"]);
    lat = decodedMap["lat"];
    lon = decodedMap["lon"];
    bedrooms = decodedMap["bedroms"];
    bathrooms = decodedMap["bathrooms"];
    unitMaxCapacity = decodedMap["capacity"];
    unitAvailableCapacity = decodedMap["available_units"];
    area = decodedMap["area"];
    floor = FloorEnumParser.parse(decodedMap["floor"]);
    imagesUrls = List<String>.from( decodedMap["urls"] as List);
    listingTitle = decodedMap["listing_title"];
    price = decodedMap["price"];
  }

  HomeDetailsModel({
    required this.listingId, required this.buildingId, required this.listingType,
    required this.district, required this.street, required this.gender, required this.lat, required this.lon,
    required this.bedrooms, required this.bathrooms,  required this.unitMaxCapacity,
    required this.unitAvailableCapacity,required this.area,
    required this.imagesUrls, required this.floor,
    required this.listingTitle, required this.price});

}
