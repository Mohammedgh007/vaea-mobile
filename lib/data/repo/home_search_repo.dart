
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/home_search_dto.dart';
import 'package:vaea_mobile/data/model/home_details_model.dart';
import 'package:vaea_mobile/data/model/searched_home_listing_model.dart';

import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/invalid_screen_access_except.dart';
import '../../helpers/excpetions/unknown_except.dart';
import '../middleware/rest/requests_container.dart';
import 'launch_requirements_repo.dart';

/// It facilitates accessing the rest api for home searching.
class HomeSearchRepo {


  /// It searches for the available unit listing based on the given filters.
  /// @throws InternetConnectionException, UnknownException
  Future<List<SearchedHomeListingModel>?> searchHomes(HomeSearchDto payload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/search-units";
        Map<String, dynamic> result = await RequestsContainer.getData(pathStr, payload.getFieldMap());
        if (result["status"] != 0) {
          return (result["data"] as List).map((e) => SearchedHomeListingModel.fromMap(e)).toList();
        } else {
          return null;
        }

      } else {
        throw InternetConnectionException(msg: "error no internet in home search");
      }
    } on Exception catch(e) {
      throw UnknownException(msg: "error in searchHomes $e");
    }
  }


  /// It retrieves the home details whose id is given.
  /// @throws InternetConnectionException, InvalidScreenAccessException
  Future<HomeDetailsModel> retrieveHomeDetails(int homeId) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/unit_details";
        Map<String, dynamic> result = await RequestsContainer.getData(pathStr, {"unit_id": homeId});
        if (result["status"] == 1) {
          return HomeDetailsModel.fromMap(result["data"]);
        } else {
          throw InvalidScreenAccessException(msg: "error invalid access");
        }

      } else {
        throw InternetConnectionException(msg: "error no internet in home details");
      }
    } on Exception catch(e) {
      throw InvalidScreenAccessException(msg: "error in home detail repo $e");
    }
  }
}