
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


/// It shows an alert for inputting invalid log in credentials
class InvalidCredentialsAlert extends StatelessWidget {

  const InvalidCredentialsAlert({super.key});

  @override
  Widget build(BuildContext context) {
    if(GetPlatform.isAndroid) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.invalidCredentialsAlertTitle),
        content: Text(AppLocalizations.of(context)!.invalidCredentialsAlertBody),
        actions: [
          TextButton( onPressed: () => handleOkBtn(context), child: Text(AppLocalizations.of(context)!.ok) )
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.invalidCredentialsAlertTitle),
        content: Text(AppLocalizations.of(context)!.invalidCredentialsAlertBody),
        actions: [
          TextButton( onPressed: () => handleOkBtn(context), child: Text(AppLocalizations.of(context)!.ok) )
        ],
      );
    }
  }

  /// It closes the alert
  void handleOkBtn(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

}