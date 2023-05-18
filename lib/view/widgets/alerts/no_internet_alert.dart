
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// It shows an alert for having no internet connection
class NoInternetAlert extends StatelessWidget {

  /// It is called after click ok button
  void Function() okHandler;

  NoInternetAlert({super.key, required this.okHandler});

  /// It calls the given handles before closing the alert
  void handleOkBtn(BuildContext context) {
    okHandler();
    Navigator.of(context, rootNavigator: true).pop();
  }


  @override
  Widget build(BuildContext context) {
    if(GetPlatform.isAndroid) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.noInternetConnectionTitle),
        content: Text(AppLocalizations.of(context)!.noInternetConnectionBody),
        actions: [
          TextButton( onPressed: () => handleOkBtn(context), child: Text(AppLocalizations.of(context)!.ok) )
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.noInternetConnectionTitle),
        content: Text(AppLocalizations.of(context)!.noInternetConnectionBody),
        actions: [
          TextButton( onPressed: () => handleOkBtn(context), child: Text(AppLocalizations.of(context)!.ok) )
        ],
      );
    }
  }


}