
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/unknown_except.dart';
import '../dto/verify_otp_dto.dart';
import '../middleware/rest/requests_container.dart';
import 'launch_requirements_repo.dart';

/// It connects VerifyAccountTerminationValidator to the rest api for verifying data in the backend.
class VerifyAccountTerminationRepo {

  /// It verifies that the correctness of otp code.
  /// @return true if the email address is not used.
  /// @throws InternetConnectionException, UnknownException.
  Future<bool> verifyOTP(VerifyOTPDto requestDto) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/verify-otp";
        Map<String, dynamic> result = await RequestsContainer.postData(pathStr, requestDto.getFieldMap());

        return result["status"] == 0;
      } else {
        throw InternetConnectionException(msg: "no interconnection in verifyotp");
      }
    } on Exception catch(e) {
      throw UnknownException(msg: "unknown $e");
    }
  }
}
