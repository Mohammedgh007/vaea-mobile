import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/screens/activities_screen.dart';
import 'package:vaea_mobile/view/screens/home_details_screen.dart';
import 'package:vaea_mobile/view/screens/home_prompt_screen.dart';
import 'package:vaea_mobile/view/screens/home_screen.dart';
import 'package:vaea_mobile/view/screens/home_search_screen.dart';
import 'package:vaea_mobile/view/screens/intro_screen.dart';
import 'package:vaea_mobile/view/screens/profile_screen.dart';
import 'package:vaea_mobile/view/screens/services_screen.dart';
import 'package:vaea_mobile/view/screens/sign_in_screen.dart';
import 'package:vaea_mobile/view/screens/sign_up_screen.dart';
import 'package:vaea_mobile/view/screens/spash_screen.dart';

/**
 * It is a helper class for main file and navigator. It stores all the routes and
 * link a given route to a Screen instance.
 */
class RoutesMapper {

  /// It links screen name with its route
  static const Map<ScreenName, String> _routesMap = {
    ScreenName.splashScreen: "/splash_screen",

    ScreenName.introScreen: "/intro",
    ScreenName.signIn: "/signIn",
    ScreenName.signUp: "/signUp",

    ScreenName.home: "/home",
    ScreenName.activities: "/activities",
    ScreenName.services: "/services",
    ScreenName.profile: "/profile",

    ScreenName.homePrompt: "/home/search-prompt",
    ScreenName.homeSearch: "/home/search-prompt/search-result",
    ScreenName.homeDetails: "/home/search-prompt/search-result/home-details"
  };


  /// It links the routes with Screen instance
  static Map<String, Widget> screensMap = {
    "errorScreen": SplashScreen(),
    _routesMap[ScreenName.splashScreen] ?? "errorScreen": SplashScreen(),

    _routesMap[ScreenName.introScreen] ?? "errorScreen": IntroScreen(),
    _routesMap[ScreenName.signIn] ?? "errorScreen": SignInScreen(),
    _routesMap[ScreenName.signUp] ?? "errorScreen": SignUpScreen(),

    _routesMap[ScreenName.home] ?? "errorScreen": HomeScreen(),
    _routesMap[ScreenName.activities] ?? "errorScreen": ActivitiesScreen(),
    _routesMap[ScreenName.services] ?? "errorScreen": ServicesScreen(),
    _routesMap[ScreenName.profile] ?? "errorScreen": ProfileScreen(),

    _routesMap[ScreenName.homePrompt] ?? "errorScreen": HomePromptScreen(),
    _routesMap[ScreenName.homeSearch] ?? "errorScreen": HomeSearchScreen(),
    _routesMap[ScreenName.homeDetails] ?? "errorScreen": HomeDetailsScreen()

  };


  /// It is used to retrieves the screen route.
  static String getScreenRoute(ScreenName screenName) {
    return _routesMap[screenName] ?? "errorScreen";
  }


  /// It is used to retrieves the screen widget.
  static Widget getScreenWidget(ScreenName screenName) {
    return screensMap[_routesMap[screenName]]!;
  }
}


/// It stores a unique name for each screen
enum ScreenName {
  splashScreen,

  introScreen,
  signIn,
  signUp,

  home,
  activities,
  services,
  profile,

  homePrompt,
  homeSearch,
  homeDetails
}