import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/repo/make_service_request_repo.dart';

class ServicesProvider extends ChangeNotifier {
  ServiceResponse? serviceResponse;
  loadServicesHistory() async {
    var serviceRepo = ServiceRepo();
    var response = await serviceRepo.loadServices();
    serviceResponse = ServiceResponse.fromJson(response);
  }
}

class ServiceRequest {
  final int requestId;
  final String requestType;
  final String status;
  final String orderDate;
  final String? appointmentDate;

  ServiceRequest({
    required this.requestId,
    required this.requestType,
    required this.status,
    required this.orderDate,
    this.appointmentDate,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      requestId: json['request_id'],
      requestType: json['request_type'],
      status: json['status'],
      orderDate: json['order_date'],
      appointmentDate: json['appointment_date'],
    );
  }
}

class ServiceResponse {
  final int status;
  final List<ServiceRequest> data;

  ServiceResponse({
    required this.status,
    required this.data,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      status: json['status'],
      data: (json['data'] as List)
          .map((i) => ServiceRequest.fromJson(i))
          .toList(),
    );
  }
}
