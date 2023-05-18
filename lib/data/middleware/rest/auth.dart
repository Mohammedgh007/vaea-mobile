
import 'package:shared_preferences/shared_preferences.dart';


/// It handles storing and accessing jwt token in the front end.
class AuthContainer {

  static const String _authKey = "JWT_TOKEN";
  static late String? token;


  /// It saves the token in the local storage.
  static void saveToken(String jwt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_authKey, jwt);
    token = jwt;
  }


  /// It retrieves and saves the token from the local storage.
  static void loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey(_authKey)) {
      token = prefs.getString(_authKey);
    }
  }


  /// It deletes the auth token locally.
  static void deleteToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     if (prefs.containsKey(_authKey)) {
       prefs.remove(_authKey);
     }

     token = null;
  }
}