
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/booking_provider.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/profile_mobile_layout.dart';
import 'package:vaea_mobile/view/widgets/modals/language_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/providers/profile_provider.dart';
import '../../bloc/providers/user_settings_provider.dart';

/// This class handles the view and its interactions with the rest of app
/// for profile screen.
class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  late final ProfileProvider profileProvider;
  late final UserSettingsProvider settingsProvider;
  late final BookingProvider bookingProvider;

  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    settingsProvider = Provider.of<UserSettingsProvider>(context, listen: false);
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);

  }


  @override
  Widget build(BuildContext context) {
    if (profileProvider.profileModel == null && profileProvider.targetScreenAfterSignIn == null) {
      profileProvider.targetScreenAfterSignIn = ScreenName.profile;
    }

    return ProfileMobileLayout(
      isSignedIn: profileProvider.profileModel != null,
      profileImageUrl: profileProvider.profileModel?.profileImageUrl,
      profileFullName: "${profileProvider.profileModel?.firstName} ${profileProvider.profileModel?.lastName}",
      preSelectedLanguage: (settingsProvider.userSettingsModel != null && settingsProvider.userSettingsModel!.languageCode != null)
        ? settingsProvider.userSettingsModel!.languageCode!
        : AppLocalizations.of(context)!.localeName,
      handleClickLanguage: handleClickLanguage,
      handleClickResetPassword: handleClickResetPassword,
      handleClickSignIn: handleClickSignIn,
      handleClickSignOut: handleClickSignOut,
    );
  }


  /// It handles the event of clicking changing the language by showing the modal language.
  void handleClickLanguage(String selectedLanguageIso) {
    settingsProvider.changeUserLanguage(selectedLanguageIso);
  }


  /// It handles the event of clicking reset password to take the user to reset password screen.
  void handleClickResetPassword() {
    Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.resetPassword));
  }


  /// It handles the event of clicking sign in
  void handleClickSignIn() {
    Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.signIn));
  }

  /// It handles the event of clicking sign out by deleting the user data locally
  /// then direct him/her to the sign in screen.
  void handleClickSignOut() {
    profileProvider.signOut();
    bookingProvider.myHomeDetails = null;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppLocalizations.of(context)!.signedOutSuccessfully)),
    );
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.splashScreen));
  }

}

