
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/confirm_booking_dto.dart';
import 'package:vaea_mobile/data/repo/booking_repo.dart';

import '../../data/model/home_details_model.dart';
import '../../helpers/excpetions/expired_token_except.dart';
import '../../helpers/excpetions/internet_connection_except.dart';

/// It handles Bloc logic for booking a listing.
class BookingProvider extends ChangeNotifier {

  /// It should be initialized before calling bookListing or using BookingScreen
  late HomeDetailsModel? listingDetailsModel;

  BookingRepo _repo = BookingRepo();
  /// It is assigned after confirming the booking
  int? bookedUnitId;


  /// It locks the unit before booking to avoid race conditions
  /// @throws InternetConnectionException, ExpiredTokenException
  Future<bool> lockUnit(int unitId) async {
    try {
      return await _repo.lockUnit(unitId);
    } on InternetConnectionException catch(e) {
      rethrow;
    } on ExpiredTokenException catch(e) {
      rethrow;
    }
  }

  /// It is used when the user pay and finalize the booking.
  /// @pre-condition it is called after a successful call for lock
  /// @throws InternetConnectionException, ExpiredTokenException
  Future<void> confirmBooking(ConfirmBookingDto requestDto) async {
    try {
      bookedUnitId = await _repo.confirmBooking(requestDto);
      notifyListeners();
    } on InternetConnectionException catch(e) {
      rethrow;
    } on ExpiredTokenException catch(e) {
      rethrow;
    }
  }


  /// It release the lock of the unit after booking's cancellation
  /// @throws InternetConnectionException, ExpiredTokenException
  Future<void> releaseUnit(int unitId) async {
    try {
      await _repo.releaseUnit(unitId);
    } on InternetConnectionException catch(e) {
      rethrow;
    } on ExpiredTokenException catch(e) {
      rethrow;
    }
  }
}