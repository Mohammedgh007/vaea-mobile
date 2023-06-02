
import 'package:vaea_mobile/helpers/excpetions/expired_token_except.dart';

import '../../helpers/excpetions/internet_connection_except.dart';
import '../dto/confirm_booking_dto.dart';
import '../middleware/rest/requests_container.dart';
import 'launch_requirements_repo.dart';

/// It facilitates accessing the rest api for booking an apartment or manage a booking
class BookingRepo {


  /// It makes sure that the clicked unit is available, and it locks it for the user.
  /// @post-condition releaseUnit must be called if the unit was not booked.
  /// @throws InternetConnectionException, ExpiredTokenException
  Future<bool> lockUnit(int unitId) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/attempt-booking";
        Map<String, dynamic> result = await RequestsContainer.postAuthData(pathStr, {"unit_id": unitId});

        return result["status"] == 0;
      } else {
        throw InternetConnectionException(msg: "error no internet in home search");
      }
    } on Exception catch(e) {
      throw ExpiredTokenException(msg: "error in lockUnit $e");
    }
  }


  /// It confirms the listing booking.
  /// @pre-condition It is called after a successful call for lockUnit
  /// @throws InternetConnectionException, ExpiredTokenException
  Future<int> confirmBooking(ConfirmBookingDto payload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/confirm-booking";
        Map<String, dynamic> result = await RequestsContainer.postAuthData(pathStr, payload.getFieldMap());

        return 12;
      } else {
        throw InternetConnectionException(msg: "error no internet in home search");
      }
    } on Exception catch(e) {
      throw ExpiredTokenException(msg: "error in confirmBooking $e");
    }
  }


  /// It releases the lock of the unit in case the user cancels the booking.
  /// @throws InternetConnectionException, ExpiredTokenException
  Future<void> releaseUnit(int unitId) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/release-attempt-booking";
        await RequestsContainer.postAuthData(pathStr, {"unit_id": unitId});

      } else {
        throw InternetConnectionException(msg: "error no internet in home search");
      }
    } on Exception catch(e) {
      throw ExpiredTokenException(msg: "error in lockUnit $e");
    }
  }
}