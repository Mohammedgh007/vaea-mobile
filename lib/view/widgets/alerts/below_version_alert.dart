
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher_string.dart';

/// It encapsulates the alert for not installing the minimum version of the app.
class BelowVersionAlert extends StatelessWidget {
  const BelowVersionAlert({super.key});

  /// It handles click event of update button
  Future<void> handleUpdateBtn(BuildContext context) async {
    Navigator.of(context).pop();
    String appStoreUrl = (GetPlatform.isAndroid)
        ? "google play url TODO"
        : "app store url TODO";

    if (await canLaunchUrlString(appStoreUrl)) {
      await launchUrlString(appStoreUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.belowVersionAlertTitle),
        content: Text(AppLocalizations.of(context)!.belowVersionAlertBody),
        actions: [
          TextButton(onPressed: () => handleUpdateBtn(context), child: Text(AppLocalizations.of(context)!.updateNow))
        ],
      );
    } else {
      return CupertinoAlertDialog(
        title: Text(AppLocalizations.of(context)!.belowVersionAlertTitle),
        content: Text(AppLocalizations.of(context)!.belowVersionAlertBody),
        actions: [
          TextButton(onPressed: () => handleUpdateBtn(context), child: Text(AppLocalizations.of(context)!.updateNow))
        ],
      );
    }
  }


}