import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/electrician_dto.dart';
import 'package:vaea_mobile/data/dto/house_cleaning_dto.dart';
import 'package:vaea_mobile/helpers/excpetions/expired_token_except.dart';

import '../../helpers/excpetions/internet_connection_except.dart';
import '../dto/plumbing_dto.dart';
import '../middleware/rest/requests_container.dart';
import '../model/request_overview_model.dart';
import 'launch_requirements_repo.dart';

/// It facilitates accessing the rest api for submitting and view service request.
class ServiceRepo {

  /// It loads the user history of requests.
  /// @pre-condition It is called only when the user is signed in.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<List<ServiceRequestOverviewModel>> loadServicesHistory() async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/get-tenant-services-requests";
        Map<String, dynamic> result = await RequestsContainer.getData(pathStr, {});
        return (result["data"] as List).map((e) => ServiceRequestOverviewModel.fromMap(e)).toList();
      } else {
        throw InternetConnectionException(msg: "no connection");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in loadServicesHistory $e");
    }
  }

  /// It submits the house cleaning request and has a lease.
  /// @pre-condition It is called only when the user is signed in.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<int> submitCleaningService(HouseCleaningDto payload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/submit-clean-house";
        Map<String, dynamic> result = await RequestsContainer.postAuthData(pathStr, payload.getFieldMap());
        return result["data"]["request_id"];
      } else {
        throw InternetConnectionException(msg: "no connection");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in submitCleaningService $e");
    }
  }


  /// It submits the plumbing request and has a lease.
  /// @pre-condition It is called only when the user is signed in.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<int> submitPlumbingService(PlumbingDto payload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/submit-plumbing";
        Map<String, dynamic> result = await RequestsContainer.postAuthData(pathStr, payload.getFieldMap());
        return result["data"]["request_id"];
      } else {
        throw InternetConnectionException(msg: "no connection");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in submitPlumbingService $e");
    }
  }


  /// It submits the electrician request and has a lease.
  /// @pre-condition It is called only when the user is signed in.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<int> submitElectricianService(ElectricianDto payload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/submit-electracian";
        Map<String, dynamic> result = await RequestsContainer.postAuthData(pathStr, payload.getFieldMap());
        return result["data"]["request_id"];
      } else {
        throw InternetConnectionException(msg: "no connection");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in submitElectricianService $e");
    }
  }

}
