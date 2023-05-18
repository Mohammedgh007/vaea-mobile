
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/forms/sign_in_form.dart';

import '../../widgets/containers/form_page_container.dart';

/// It handles the ui appearance and user interaction for SignInScreen.
class SignInMobileLayout extends StatefulWidget {

  String? Function(String? input) validateEmailAddress;
  String? Function(String? input) validatePassword;
  Future<bool> Function({
  required String emailAddress,
  required String password
  }) handleSubmitSignInForm;

  SignInMobileLayout({
    super.key,
    required this.validateEmailAddress,
    required this.validatePassword,
    required this.handleSubmitSignInForm
  });

  @override
  State<SignInMobileLayout> createState() => _SignInMobileLayoutState();
}

class _SignInMobileLayoutState extends State<SignInMobileLayout> {

  late Breakpoint breakpoint;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        breakpoint = Breakpoint.fromConstraints(constraints);

        return Scaffold(
          body: FormPageContainer(
            breakpoint: breakpoint,
            layoutBoxConstrains: constraints,
            pageForm: buildSignInForm(constraints),
            pageTitle: AppLocalizations.of(context)!.welcomeHomeTitle
          ),
        );
      },
    );
  }


  /// It is a helper method. It builds the sign in form.
  Widget buildSignInForm(BoxConstraints constraints) {
    return SignInForm(
      breakpoint: breakpoint,
      layoutConstraints: constraints,
      validateEmailAddress: widget.validateEmailAddress,
      validatePassword: widget.validatePassword,
      handleSubmitSignIn: widget.handleSubmitSignInForm
    );
  }


}