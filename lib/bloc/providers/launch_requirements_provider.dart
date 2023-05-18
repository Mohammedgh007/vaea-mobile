
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/repo/launch_requirements_repo.dart';

/// It is the BloC component for accessing the launch requirements in the view.
class LaunchRequirementsProvider extends ChangeNotifier {

  bool? hasInternetConnection;
  bool? useMinimumAppVersion;


  /// It checks the requirements for launching the app. After it finishes, the values
  /// of hasInternetConnection and useMinimumAppVersion will be set.
  /// @pre-condition: userSettingsModel must be initialized.
  Future<void> checkLaunchRequirements() async {
    hasInternetConnection = await LaunchRequirementRepo.checkInternetConnection();
    if (hasInternetConnection!) {
      useMinimumAppVersion = await LaunchRequirementRepo.checkMinimumVersion();
    }
    notifyListeners();
  }

}