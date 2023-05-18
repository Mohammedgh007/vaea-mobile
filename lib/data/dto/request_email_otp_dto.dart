
/// It stores the fields that stores the body of rest api request that is sent
/// for sending otp verification.
class RequestEmailOTPDto {

  String emailAddress;
  /// It must be either REGISTRATION or TERMINATION
  String requestType;
  /// It must be either en or ar
  String languageIso;


  RequestEmailOTPDto({
    required this.emailAddress, required this.requestType, required this.languageIso
  });


  /// It is used to convert the fields to map in order to be converted as a json object.
  Map<String, dynamic> getFieldMap() {
    return {
      "email_address": emailAddress,
      "request_type": requestType,
      "language_iso": languageIso
    };
  }

}