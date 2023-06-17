import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/launch_requirements_provider.dart';
import 'package:vaea_mobile/bloc/providers/profile_provider.dart';
import 'package:vaea_mobile/bloc/providers/user_settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/helpers/Env.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/loading_mobile_layout.dart';
import 'package:vaea_mobile/view/widgets/alerts/below_version_alert.dart';
import 'package:vaea_mobile/view/widgets/alerts/no_internet_alert.dart';

/// This class handles the view and its interactions with the rest of app
/// for splash screen.
class SplashScreen extends StatefulWidget {

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  late final LaunchRequirementsProvider requirementsProvider;
  late final UserSettingsProvider settingsProvider;
  late final ProfileProvider profileProvider;

  @override
  void initState() {
    super.initState();

    // initialize the providers
    requirementsProvider = Provider.of<LaunchRequirementsProvider>(context, listen: false);
    settingsProvider = Provider.of<UserSettingsProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setupApp();
    });
  }


  /// It setups using the app by checking launch requirements, user settings, and
  /// loading authentication token.
  Future<void> setupApp() async{ return;
    // calling the providers to setup the app.
    await Future.wait([
      requirementsProvider.checkLaunchRequirements(),
      settingsProvider.loadSettings(),
      profileProvider.loadProfileInfo()
    ]);

    // notify the view for the result.
    if (requirementsProvider.hasInternetConnection! && requirementsProvider.useMinimumAppVersion!) { // it is ready to launch
      handlePassingRequirements();
    } else { // fail
      if (!requirementsProvider.hasInternetConnection! ) {
        handleNoInternetConnection();
      } else {
        handleBelowMinimumAppVersion();
      }
    }
  }


  /// It is a helper method for setupApp. It handles the case of passing launch requirements
  void handlePassingRequirements() {
    if (settingsProvider.userSettingsModel!.languageCode == null) { // the user is new
      Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.introScreen));
      settingsProvider.changeUserLanguage(AppLocalizations.of(context)!.localeName);
    } else {
      Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.home));
    }
  }


  /// It handles the fail case that is caused by lacking the internet connection.
  void handleNoInternetConnection() {
    showDialog(
      context: context,
      builder: (ctx) => NoInternetAlert(okHandler: () => setupApp())
    );
  }


  /// It handles the fail case that is caused by having below minimum app version.
  void handleBelowMinimumAppVersion() {
    showDialog(context: context, builder: (ctx) => BelowVersionAlert());
  }

  @override
  Widget build(BuildContext context) {

    debugPrint("is dev " + Env.isDevEnv.toString() + " isTest " + Env.isTestEnv.toString() + " isProd " + Env.isProdEnv.toString());
    return LoadingMobileLayout();
  }


}