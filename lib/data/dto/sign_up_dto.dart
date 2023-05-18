
import '../enums/gender.dart';
import 'dart:io';

/// It stores the fields that stores the body of rest api request that is sent
/// for registering the user.
class SignUpDto {

  String firstName;
  String lastName;
  Gender gender;
  /// It is optional
  File? profileImage;
  String idIqamaNumber;
  String emailAddress;
  String password;
  /// It must be either ar or en
  String isoLanguage;


  SignUpDto({
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.profileImage,
    required this.idIqamaNumber,
    required this.emailAddress,
    required this.password,
    required this.isoLanguage
     });

  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "gender": GenderSerializer.serialize(gender),
      "profile_image": (profileImage),
      "id_iqama_number": idIqamaNumber,
      "email_address": emailAddress,
      "password": password,
      "language_iso": isoLanguage
    };
  }

}