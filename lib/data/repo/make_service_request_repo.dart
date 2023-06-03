import 'package:vaea_mobile/helpers/excpetions/expired_token_except.dart';

import '../../helpers/excpetions/internet_connection_except.dart';
import '../middleware/rest/requests_container.dart';
import 'launch_requirements_repo.dart';

/// It facilitates accessing the rest api for booking an apartment or manage a booking
class ServiceRepo {
  Future loadServices() async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/get-tenant-services-requests";
        Map<String, dynamic> result =
            await RequestsContainer.getData(pathStr, {});
        print('result$result');
        return result;
      } else {
        throw InternetConnectionException(
            msg: "error no internet in home search");
      }
    } on Exception catch (e) {
      throw ExpiredTokenException(msg: "error in lockUnit $e");
    }
  }

  Future makeRequest(
      {required String supUrl,
      required String preferedDate,
      required String room,
      required String category,
      required String description,
      String? notes}) async {
    var body = {
      "prefered_date": preferedDate,
      "room": room,
      "category": category,
      "description": description,
      "notes": notes,
    };
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/$supUrl";
        Map<String, dynamic> result =
            await RequestsContainer.postAuthData(pathStr, body);

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
