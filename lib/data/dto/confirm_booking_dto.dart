
import 'package:vaea_mobile/data/enums/payment_provider_enum.dart';

import '../enums/lease_period_enum.dart';

/// It stores the fields that stores the body of rest api request that is sent
/// for confimring the booking
class ConfirmBookingDto {

  int unitId;
  PaymentProviderEnum paymentProvider;
  String paymentId;
  LeasePeriodEnum leasePeriod;
  DateTime startingDate;
  DateTime endingDate;

  ConfirmBookingDto({
    required this.unitId,
    required this.paymentProvider,
    required this.paymentId,
    required this.leasePeriod,
    required this.startingDate,
    required this.endingDate
  });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "unit_id": unitId,
      "payment_provider": PaymentProviderEnumSerializer.serialize(paymentProvider),
      "payment_id": paymentId,
      "lease_period_type": LeasePeriodEnumSerializer.serialize(leasePeriod),
      "starting_date": startingDate.toIso8601String(),
      "ending_date": endingDate.toIso8601String()
    };
  }
}