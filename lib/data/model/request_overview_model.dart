

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';
import 'package:vaea_mobile/data/enums/service_status_enum.dart';
import 'package:vaea_mobile/data/enums/service_type_enum.dart';

import '../enums/gender.dart';

/// It represents a service request overview.
class ServiceRequestOverviewModel {

  late int requestId;
  late ServiceTypeEnum serviceType;
  late ServiceStatusEnum serviceStatus;
  late DateTime orderDate;
  DateTime? appointmentDate;

  /// It constructs the instance based on the decoded map from the search result.
  ServiceRequestOverviewModel.fromMap(Map<String, dynamic> decodedMap) {
    requestId = decodedMap["request_id"];
    serviceType = ServiceTypeEnumParser.parse(decodedMap["request_type"]);
    serviceStatus = ServiceStatusEnumParser.parse(decodedMap["status"]);
    orderDate = DateFormat("yyyy-MM-ddTHH:mm").parse(decodedMap["order_date"]);
    appointmentDate = (decodedMap["appointment_date"] != null)
      ? DateFormat("yyyy-MM-ddTHH:mm").parse(decodedMap["appointment_date"])
      : null;
  }

  ServiceRequestOverviewModel({
    required this.requestId, required this.serviceType, required this.serviceStatus,
    required this.orderDate, required this.appointmentDate
  });

}
