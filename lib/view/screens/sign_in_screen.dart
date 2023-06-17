import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/validators/sign_in_validator.dart';
import 'package:vaea_mobile/helpers/excpetions/internet_connection_except.dart';
import 'package:vaea_mobile/helpers/excpetions/invalid_credentials_except.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/sign_in_mobile_layout.dart';
import 'package:vaea_mobile/view/widgets/alerts/invalid_credentials_alert.dart';

import '../../bloc/providers/profile_provider.dart';
import '../../bloc/providers/user_settings_provider.dart';
import '../../data/dto/sign_in_dto.dart';
import '../widgets/alerts/no_internet_alert.dart';

/// This class handles the view and its interactions with the rest of app
/// for sign in screen.
class SignInScreen extends StatefulWidget {

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  late final ProfileProvider profileProvider;
  late final UserSettingsProvider settingsProvider;

  late SignInValidator validator;

  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    settingsProvider = Provider.of<UserSettingsProvider>(context, listen: false);
    validator = SignInValidator(context: context);
  }

  @override
  Widget build(BuildContext context) {

    return SignInMobileLayout(
      validateEmailAddress: validator.validateEmailAddress,
      validatePassword: validator.validatePassword,
      handleSubmitSignInForm: handleSubmitSignInForm,
    );
  }


  /// It handles submitting the sign in form. also, it handles showing error alerts
  Future<bool> handleSubmitSignInForm({ required String emailAddress, required String password }) async {
    try {
      SignInDto requestDto = SignInDto(emailAddress: emailAddress, password: password);
      String userLanguage = await profileProvider.signIn(requestDto);
      settingsProvider.changeUserLanguage(userLanguage);

      if (profileProvider.targetScreenAfterSignIn == null) {
        Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.home));
      } else {
        Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(profileProvider.targetScreenAfterSignIn!));
        profileProvider.targetScreenAfterSignIn = null;
      }

    } on InternetConnectionException catch(e) {
      showDialog(
          context: context,
          builder: (ctx) => NoInternetAlert(okHandler: () {})
      );
    } on InvalidCredentialsException catch(e) {
      showDialog(
          context: context,
          builder: (ctx) => const InvalidCredentialsAlert()
      );
    }
    return false;
  }



}