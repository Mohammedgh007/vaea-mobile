
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/data/dto/confirm_booking_dto.dart';
import 'package:vaea_mobile/data/enums/lease_period_enum.dart';
import 'package:vaea_mobile/data/enums/payment_provider_enum.dart';
import 'package:vaea_mobile/data/middleware/rest/auth.dart';
import 'package:vaea_mobile/helpers/excpetions/internet_connection_except.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/booking_mobile_layout.dart';

import '../../bloc/providers/booking_provider.dart';

/// It handles interacting with the ui widgets and the rest of app
class BookingScreen extends StatefulWidget {

  @override
  State<BookingScreen> createState() => _BookingScreenState();

}

class _BookingScreenState extends State<BookingScreen> {


  late BookingProvider bookingProvider;
  bool hasConfirmedBooking = false;

  @override
  void initState() {
    super.initState();

    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
  }


  @override
  void dispose() {
    if (!hasConfirmedBooking) {
      bookingProvider.releaseUnit(bookingProvider.listingDetailsModel!.listingId);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BookingMobileLayout(
      listingModel: bookingProvider.listingDetailsModel!,
      handleConfirmBooking: handleConfirmBook,
      handleClickFinish: handleClickFinish,
    );
  }


  /// It handles confirming the booking.
  /// @return true if it was successful in the backend
  Future<bool> handleConfirmBook(
      {
        required PaymentProviderEnum paymentProvider,
        required String paymentId,
        required LeasePeriodEnum leasePeriodType,
        required DateTime startingDate,
        required DateTime endingDate
      }) async {
    try {
      ConfirmBookingDto requestDto = ConfirmBookingDto(
        unitId: bookingProvider.listingDetailsModel!.listingId,
        paymentProvider: paymentProvider,
        paymentId: paymentId,
        leasePeriod: leasePeriodType,
        startingDate: startingDate,
        endingDate: endingDate
      );
      await bookingProvider.confirmBooking(requestDto);
      setState(() => hasConfirmedBooking = true);
      return true;
    } on InternetConnectionException catch(e) {
      // TODO
      return false;
    }
  }


  /// It takes the user to hame screen.
  void handleClickFinish() {
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.home));
  }
}