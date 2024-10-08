import 'package:vaea_mobile/helpers/excpetions/expired_token_except.dart';

import '../../helpers/excpetions/internet_connection_except.dart';
import '../middleware/rest/requests_container.dart';
import 'launch_requirements_repo.dart';

/// It facilitates accessing the rest api for booking an apartment or manage a booking
class ActivitiesRepo {
  Future loadActivities(String monthNumber) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr =
            "/tenants/get-month-activities?month=$monthNumber&city=RIYADH";
        Map<String, dynamic> result =
            await RequestsContainer.getData(pathStr, {});
        return result;
      } else {
        throw InternetConnectionException(
            msg: "error no internet in home search");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in lockUnit $e");
    }
  }

  Future loadActivity(String id) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/get-activity-details?activity_id=$id";
        print(pathStr);
        Map<String, dynamic> result =
            await RequestsContainer.getData(pathStr, {});
        return result;
      } else {
        throw InternetConnectionException(
            msg: "error no internet in home search");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in lockUnit $e");
    }
  }
}
