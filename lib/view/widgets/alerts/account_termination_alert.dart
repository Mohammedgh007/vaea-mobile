
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:vaea_mobile/routes_mapper.dart';

/// It encapsulates the alert for the user that account termination is not reversible.
class AccountTerminationAlert extends StatelessWidget {

  const AccountTerminationAlert({super.key});

  /// It handles click event of update button
  void handleClickProceed(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.accountTermination));
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.accountTerminationAlertTitle),
        content: Text(AppLocalizations.of(context)!.accountTerminationAlertBody),
        actions: [
          TextButton(onPressed: () => handleClickProceed(context), child: Text(AppLocalizations.of(context)!.proceed)),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel))
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.accountTerminationAlertTitle),
        content: Text(AppLocalizations.of(context)!.accountTerminationAlertBody),
        actions: [
          TextButton(onPressed: () => handleClickProceed(context), child: Text(AppLocalizations.of(context)!.proceed)),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel))
        ],
      );
    }
  }


}