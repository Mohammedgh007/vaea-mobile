
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/validators/account_termination_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/layouts/mobile/account_termination_mobile_layout.dart';

import '../../bloc/providers/profile_provider.dart';
import '../../data/dto/request_email_otp_dto.dart';
import '../../routes_mapper.dart';

/// It handles interacting with the ui widgets and the rest of app for terminating
/// the user account
class AccountTerminationScreen extends StatefulWidget {

  @override
  State<AccountTerminationScreen> createState() => _AccountTerminationScreenState();
}

class _AccountTerminationScreenState extends State<AccountTerminationScreen> {

  late final ProfileProvider profileProvider;
  late AccountTerminationValidator validator;

  // inputs
  String terminationReason = "";

  @override
  void initState() {
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    validator = AccountTerminationValidator(context: context);
  }

  @override
  Widget build(BuildContext context) {

    return AccountTerminationMobileLayout(
      validateOtp: (String? input ) => validator.validateOTP(input, profileProvider.profileModel!.emailAddress),
      handleSubmitReason: handleSubmitReason,
      handleTerminate: handleFinalSubmit
    );
  }

  /// It saves the input and send otp
  void handleSubmitReason(String reason) {
    terminationReason = reason;

    // request to send otp
    RequestEmailOTPDto requestDto = RequestEmailOTPDto(
        emailAddress: profileProvider.profileModel!.emailAddress,
        requestType: "TERMINATION",
        languageIso: AppLocalizations.of(context)!.localeName
    );
    profileProvider.requestEmailOTP(requestDto);
  }


  /// It handling terminating the account after validating the otp
  Future<bool> handleFinalSubmit() async {
    await profileProvider.terminateAccount(terminationReason);
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.splashScreen));
    return true;
  }

}
