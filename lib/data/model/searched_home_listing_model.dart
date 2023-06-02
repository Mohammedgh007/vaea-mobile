
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';

/// It represents the properties of the search result of a housing unit..
class SearchedHomeListingModel {

  late int listingId;
  late HomeType listingType;
  late DistrictEnum district;
  late double lat;
  late double lon;
  late int bedrooms;
  late int bathrooms;
  late int unitMaxCapacity;
  late int unitAvailableCapacity;
  late List<String> imagesUrls;
  late String listingTitle;
  late int price;

  /// It constructs the instance based on the decoded map from the search result.
  SearchedHomeListingModel.fromMap(Map<String, dynamic> decodedMap) {
    listingId = decodedMap["unit_id"];
    listingType = HomeTypeParser.parse(decodedMap["unit_type"]);
    district = DistrictEnumParser.parse(decodedMap["district"]);
    lat = decodedMap["lat"];
    lon = decodedMap["lon"];
    bedrooms = decodedMap["bedroms"];
    bathrooms = decodedMap["bathrooms"];
    unitMaxCapacity = decodedMap["capacity"];
    unitAvailableCapacity = decodedMap["available_units"];
    imagesUrls = List<String>.from( decodedMap["urls"] as List);
    listingTitle = decodedMap["listing_title"];
    price = decodedMap["price"];
  }

  SearchedHomeListingModel({
    required this.listingId, required this.listingType, required this.district,
    required this.lat, required this.lon, required this.bedrooms, required this.bathrooms,
    required this.unitMaxCapacity, required this.unitAvailableCapacity, required this.imagesUrls,
    required this.listingTitle, required this.price});

}
