import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/electrician_dto.dart';
import 'package:vaea_mobile/data/dto/house_cleaning_dto.dart';
import 'package:vaea_mobile/data/dto/plumbing_dto.dart';
import 'package:vaea_mobile/data/enums/service_status_enum.dart';

import '../../data/model/request_overview_model.dart';
import '../../data/repo/service_repo.dart';
import '../../helpers/excpetions/expired_token_except.dart';
import '../../helpers/excpetions/internet_connection_except.dart';

class ServicesProvider extends ChangeNotifier {

  final ServiceRepo _repo = ServiceRepo();
  List<ServiceRequestOverviewModel> prevRequests = [];
  List<ServiceRequestOverviewModel> currRequests = [];


  /// It loads the user history of requests.
  /// @pre-condition It is called only when the user is signed in and has a lease.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<void> loadHistory() async {
    try {
      List<ServiceRequestOverviewModel> requests = await _repo.loadServicesHistory();

      prevRequests = [];
      currRequests = [];
      for (ServiceRequestOverviewModel req in requests) {
        if (req.serviceStatus == ServiceStatusEnum.concluded) {
          prevRequests.add(req);
        } else {
          currRequests.add(req);
        }
      }

      prevRequests.sort((a, b) => a.orderDate.compareTo(b.orderDate));
      currRequests.sort((a, b) => a.orderDate.compareTo(b.orderDate));
      notifyListeners();
    } on ExpiredTokenException catch(e) {
      rethrow;
    } on InternetConnectionException catch(e) {
      rethrow;
    }
  }


  /// It submits the house cleaning request.
  /// @pre-condition It is called only when the user is signed in and has a lease.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<int> submitCleaningService(HouseCleaningDto requestDTO) {
    try {
      return _repo.submitCleaningService(requestDTO);
    } on ExpiredTokenException catch(e) {
      rethrow;
    } on InternetConnectionException catch(e) {
      rethrow;
    }
  }


  /// It submits the plumbing request.
  /// @pre-condition It is called only when the user is signed in and has a lease.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<int> submitPlumbingService(PlumbingDto requestDTO) {
    try {
      return _repo.submitPlumbingService(requestDTO);
    } on ExpiredTokenException catch(e) {
      rethrow;
    } on InternetConnectionException catch(e) {
      rethrow;
    }
  }


  /// It submits the electrician request.
  /// @pre-condition It is called only when the user is signed in and has a lease.
  /// @throws ExpiredTokenException, InternetConnectionException
  Future<int> submitElectricianService(ElectricianDto requestDTO) {
    try {
      return _repo.submitElectricianService(requestDTO);
    } on ExpiredTokenException catch(e) {
      rethrow;
    } on InternetConnectionException catch(e) {
      rethrow;
    }
  }

}
