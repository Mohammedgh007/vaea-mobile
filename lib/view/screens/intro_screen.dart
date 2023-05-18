
import 'package:flutter/material.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/intro_mobile_layout.dart';

/// This class handles the view and its interactions with the rest of app
/// for intro screen.
class IntroScreen extends StatefulWidget {

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  /// It handles clicking sign up button by taking the user to SignUpScreen
  handleClickSignUp() {
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.signUp));
  }

  @override
  Widget build(BuildContext context) {

    return IntroMobileLayout(
      handleClickSignUp: handleClickSignUp,
    );
  }


}