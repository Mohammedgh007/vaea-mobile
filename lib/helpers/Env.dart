import 'package:flutter_dotenv/flutter_dotenv.dart';

/// It is a helper class that provides an access to the env variables.
class Env {

  static final bool isDevEnv = dotenv.env["ENV_TYPE"] == "DEV";
  static final bool isTestEnv = dotenv.env["ENV_TYPE"] == "TEST";
  static final bool isProdEnv = dotenv.env["ENV_TYPE"] == "PROD";

  static final String apiUrl = dotenv.env["API_URL"]!;
  static final String apiPort = dotenv.env["API_PORT"]!;

  static final String moyasarAPI = dotenv.env["MOYASAR_API_KEY"]!;
  static final String applePayMerchantId = dotenv.env["APPLE_PAY_MERCHANT_ID"]!;
}