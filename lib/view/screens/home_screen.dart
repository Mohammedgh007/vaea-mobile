
import 'package:flutter/material.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/home_mobile_layout.dart';

/// This class handles the view and its interactions with the rest of app
/// for home screen.
class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {

    return HomeMobileLayout(
      homeModel: null,
      handleClickFindHome: handleClickFindHome,
    );
  }


  /// It handles the button by taking the user to search prompt screen before going
  /// to the search result.
  void handleClickFindHome() {
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.homePrompt));
  }


}

