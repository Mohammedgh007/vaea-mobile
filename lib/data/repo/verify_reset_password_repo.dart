
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/verify_otp_dto.dart';
import 'package:vaea_mobile/data/middleware/rest/requests_container.dart';
import 'package:vaea_mobile/data/repo/launch_requirements_repo.dart';
import 'package:vaea_mobile/helpers/excpetions/internet_connection_except.dart';
import 'package:vaea_mobile/helpers/excpetions/unknown_except.dart';

/// It connects SignInValidator to the rest api for verifying data in the backend.
class VerifyResetPasswordRepo {

  /// It verifies that the email is being used a user.
  /// @return true if the email address is used.
  /// @throws InternetConnectionException, UnknownException
  Future<bool> verifyEmail(String emailAddress) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/verify-email";
        Map<String, dynamic> result = await RequestsContainer.getData(pathStr, {
          "email_address": emailAddress
        });

        return !result["data"]["was_not_used"];
      } else {
        throw InternetConnectionException(msg: "no intenerconnection in verifyEmail");
      }
    } on Exception catch(e) {
      throw UnknownException(msg: "unknown $e");
    }
  }


  /// It verifies that the email is not being used by other users.
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