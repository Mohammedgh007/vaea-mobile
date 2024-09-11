
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vaea_mobile/data/middleware/rest/requests_container.dart';
import 'package:vaea_mobile/helpers/Env.dart';

/// It handles validating the requirement of launching this app that includes
/// minimum version and internet connection.
class LaunchRequirementRepo {

  /// It checks the internet connection via pinging google.com.
  /// @return true if the user is connected to the internet.
  static Future<bool> checkInternetConnection() async{
    if (!Env.isProdEnv) {return true;}

    try {
      final result = await InternetAddress.lookup("www.google.com");
      return (result.isNotEmpty && result[0].rawAddress.isNotEmpty) ;
    } on Exception catch(e) {
      return false;
    }
  }


  /// It checks if the current version is above the minimum version.
  /// @pre-condition there is a stable internet connection.
  static Future<bool> checkMinimumVersion() async{ return true;
    try {
      // retrieves the minimum version from the server
      String pathStr = "/tenants/get-minimum-mobile-version";
      String minVersion = (await RequestsContainer.getData(pathStr, null))["data"]["minimum_version"];
      int minMajor = int.parse(minVersion.substring(0, minVersion.indexOf(".")));
      int minMinor = int.parse( minVersion.substring(minVersion.indexOf(".") + 1, minVersion.lastIndexOf(".")) );
      int minPatch = int.parse( minVersion.substring(minVersion.lastIndexOf(".") + 1) );

      // retrieving the running app version
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      debugPrint("curr $version  target $minVersion");
      int major = int.parse(version.substring(0, version.indexOf(".")));
      int minor = int.parse( version.substring(version.indexOf(".") + 1, version.lastIndexOf(".")) );
      int patch = int.parse( version.substring(version.lastIndexOf(".") + 1) );

      // return true if the running app uses the minimum version
      return (major > minMajor ||
          (major == minMajor && minor > minMinor) ||
          (major == minMajor && minor == minMinor && patch >= minPatch));
    } on Exception catch(e) {
      return false;
    }
  }
}