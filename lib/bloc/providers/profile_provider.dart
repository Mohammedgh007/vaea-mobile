
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/request_email_otp_dto.dart';
import 'package:vaea_mobile/data/dto/sign_in_dto.dart';
import 'package:vaea_mobile/data/dto/sign_up_dto.dart';
import 'package:vaea_mobile/data/model/user_profile_model.dart';
import 'package:vaea_mobile/data/repo/profile_repo.dart';
import 'package:vaea_mobile/helpers/excpetions/invalid_credentials_except.dart';

import '../../data/dto/save_user_profile_dto.dart';
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/unknown_except.dart';

/// It is the BloC component for accessing user registration in the view.
class ProfileProvider extends ChangeNotifier {

  final ProfileRepo _repo = ProfileRepo();

  UserProfileModel? profileModel;

  /// It loads the profile info from the local storage. Also, it setups the auth data.
  Future<void> loadProfileInfo() async {
    profileModel = await _repo.loadUserprofile();
    notifyListeners();
  }

  /// It sends an email for otp verification.
  /// @throws InternetConnectionException, UnknownException
  Future<void> requestEmailOTP(RequestEmailOTPDto requestDTO) async {
    try {
      await _repo.requestOTP(requestDTO);
    } on InternetConnectionException catch(e) {
      rethrow;
    } on UnknownException catch(e) {
      rethrow;
    }
  }

  /// It finalizes the registration.
  /// @throws InternetConnectionException, UnknownException
  Future<void> signUpTenant(SignUpDto signUpDto, SaveUserProfileDto saveUserProfileDto) async {
    try {
      String? profileImageUrl = await _repo.signUpTenant(signUpDto, saveUserProfileDto);
      profileModel = UserProfileModel(
        firstName: signUpDto.firstName,
        lastName: signUpDto.lastName,
        emailAddress: signUpDto.emailAddress,
        userLanguage: signUpDto.isoLanguage,
        profileImageUrl: profileImageUrl
      );
    } on InternetConnectionException catch(e) {
      rethrow;
    } on UnknownException catch(e) {
      rethrow;
    }
  }


  /// It lets the user sign in.
  /// @throws InternetConnectionException, InvalidCredentialsException
  /// @return user language.
  Future<String> signIn(SignInDto requestDto) async {
    try {
      profileModel = await _repo.signInTenant(requestDto);
      notifyListeners();
      return profileModel!.userLanguage;
    } on InternetConnectionException catch(e) {
      rethrow;
    } on InvalidCredentialsException catch(e) {
      rethrow;
    }
  }


  /// It lets the user sign out
  Future<void> signOut() async {
    _repo.signOut();
  }

}