
/// It stores the fields that stores the body of rest api request that is sent
/// for otp verification.
class VerifyOTPDto {

  String emailAddress;
  String otpCode;


  VerifyOTPDto({
    required this.emailAddress, required this.otpCode
  });


  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "email_address": emailAddress,
      "otp_code": otpCode,
    };
  }

}