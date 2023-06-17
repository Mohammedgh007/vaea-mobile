
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/request_email_otp_dto.dart';
import 'package:vaea_mobile/data/dto/save_user_profile_dto.dart';
import 'package:vaea_mobile/data/dto/sign_in_dto.dart';
import 'package:vaea_mobile/data/dto/sign_up_dto.dart';
import 'package:vaea_mobile/data/middleware/local_db/user_profile_storage.dart';
import 'package:vaea_mobile/data/middleware/rest/auth.dart';
import 'package:vaea_mobile/data/middleware/rest/requests_container.dart';
import 'package:vaea_mobile/data/model/user_profile_model.dart';
import 'package:vaea_mobile/data/repo/launch_requirements_repo.dart';
import 'package:vaea_mobile/helpers/excpetions/invalid_credentials_except.dart';
import 'package:vaea_mobile/helpers/excpetions/unknown_except.dart';

import '../../helpers/excpetions/internet_connection_except.dart';
import '../dto/reset_password_dto.dart';

/// It facilitates accessing the backend of user registration to SignUpProvider.
class ProfileRepo {

  late UserProfileStorage _profileStorage;

  ProfileRepo() {
    _profileStorage = UserProfileStorage();
  }


  /// It loads the profile info from the storage. also, it loads and setups the auth data.
  Future<UserProfileModel?> loadUserprofile() async {
    Map<String, dynamic>? result = await _profileStorage.loadUserProfile();
    AuthContainer.loadToken();
    if (result == null) {// there is not profile
      return null;
    }

    UserProfileModel model = UserProfileModel.fromMap(result);
    return model;
  }

  /// It sends a request to the backend to send a verification code in the given email.
  /// @throws InternetConnectionException, UnknownException
  Future<void> requestOTP(RequestEmailOTPDto payload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/send-otp";
        await RequestsContainer.postData(pathStr, payload.getFieldMap());
      } else {
        throw InternetConnectionException(msg: "error no internet in requestOTP");
      }
    } on Exception catch(e) {
      throw UnknownException(msg: "error in requestOTP $e");
    }
  }

  /// It sends a request to sign up the user.
  /// @pre-condition the email has to be verified and the otp code has to be sent
  /// @throws InternetConnectionException, UnknownException
  /// @return the profile image url so that provider can create the profile model
  Future<String?> signUpTenant(SignUpDto payload, SaveUserProfileDto localStoragePayload) async {
    try {
      if (await LaunchRequirementRepo.checkInternetConnection()) {
        String pathStr = "/tenants/register";
        Map<String, dynamic> result = await RequestsContainer.postFormData(pathStr, payload.getFieldMap());
        AuthContainer.saveToken(result["data"]["auth_token"]);

        String? profileImageUrl = result["data"]["profile_image_url"];
        localStoragePayload.profileImageUrl = (profileImageUrl == null) ? "" : profileImageUrl;
        _profileStorage.saveProfileImage(localStoragePayload);

        return profileImageUrl;
      } else {
        throw InternetConnectionException(msg: "error no internet in requestOTP");
      }
    } on Exception catch(e) {
      throw UnknownException(msg: "error in requestOTP $e");
    }
  }


  /// It sign in the user and retrieves its profile info.
  /// @throws InternetConnectionException, InvalidCredentialsException
  Future<UserProfileModel> signInTenant(SignInDto payload) async {
    try {
      String pathStr = "/tenants/sign-in";
      Map<String, dynamic> result = await RequestsContainer.postData(pathStr, payload.getFieldMap());
      AuthContainer.saveToken(result["data"]["auth_token"]);

      result["data"]["email_address"] = payload.emailAddress;
      UserProfileModel model = UserProfileModel.fromMap(result["data"]);

      SaveUserProfileDto saveLocallyDto = SaveUserProfileDto(
        firstName: model.firstName,
        lastName: model.lastName,
        emailAddress: payload.emailAddress,
        profileImageUrl: ( model.profileImageUrl == null ) ? "" : model.profileImageUrl!,
        userLanguage: model.userLanguage
      );
      _profileStorage.saveProfileImage(saveLocallyDto);

      return model;
    } on Exception catch(e) {
      throw InvalidCredentialsException(msg: "error in auth sign in $e");
    }
  }


  /// It lets the user to reset the password after otp verification
  /// @throws InternetConnectionException, InvalidCredentialsException
  Future<void> resetPassword(ResetPasswordDto payload) async {
    try {
      String pathStr = "/tenants/reset-password";
      await RequestsContainer.postData(pathStr, payload.getFieldMap());
    } on Exception catch(e) {
      throw InvalidCredentialsException(msg: "error in resetPassowrd $e");
    }
  }

  /// It terminates the user account.
  /// @pre-condition termination otp has been requested and verified.
  /// @throws InternetConnectionException, UnknownException
  Future<void> terminateAccount(String reason) async {
    try {
      String pathStr = "/tenants/terminate-account";
      Map<String, dynamic> result = await RequestsContainer.postAuthData(pathStr, {"reason": reason});
      signOut();
    } on Exception catch(e) {
      throw UnknownException(msg: "error in terminateAccount $e");
    }
  }


  /// It lets the user sign out by deleting its profile and auth data
  Future<void> signOut() async {
    AuthContainer.deleteToken();

    await _profileStorage.deleteUserProfile();
  }


}