
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../../../routes_mapper.dart';
import '../buttons/primary_button.dart';
import '../fields/text_field.dart';

/// It builds, validates, and manages the sign in form in SignInMobileLayout.
class SignInForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;


  String? Function(String? input) validateEmailAddress;
  String? Function(String? input) validatePassword;
  Future<bool> Function({
    required String emailAddress,
    required String password
  }) handleSubmitSignIn;

  SignInForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validateEmailAddress,
    required this.validatePassword,
    required this.handleSubmitSignIn
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {

  // inputs
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // error message
  String? emailAddressErrorMsg;
  String? passwordErrorMsg;

  bool isUpload = false;

  // dimensions
  late double fieldsSpacer;
  late double fieldsBtnSpacer;


  @override
  void initState() {
    super.initState();

    setupDimensions();
  }

  /// It is a helper method to initState. It setups the dimensions in the form.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = fieldsSpacer * 1.5;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = fieldsSpacer * 1.5;
    } else {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = fieldsSpacer * 1.5;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.layoutConstraints.maxWidth * 0.92,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSeparatedFields(),
          SizedBox(height: fieldsBtnSpacer),
          PrimaryBtn(
            breakpoint: widget.breakpoint,
            layoutConstraints: widget.layoutConstraints,
            handleClick: handleSubmit,
            buttonText: AppLocalizations.of(context)!.signIn
          ),
          SizedBox(height: widget.layoutConstraints.maxHeight * 0.015),
          buildSignUpPrompt(),
          SizedBox(height: fieldsSpacer * 2),
        ],
      ),
    );
  }


  /// It is a helper method. It builds the list of fields.
  Widget buildSeparatedFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEmailAddressField(),
        SizedBox(height: fieldsSpacer),
        buildPasswordField(),
      ],
    );
  }

  /// It is a helper method for buildSeparatedFields. It builds email address field
  Widget buildEmailAddressField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: emailAddressController,
      labelStr: AppLocalizations.of(context)!.emailAddressFieldLabel,
      hintStr: AppLocalizations.of(context)!.emailAddressFieldHint,
      textInputAction: TextInputAction.next,
      isTextObscure: false,
      errorMsg: emailAddressErrorMsg,
      handleOnSubmitted: (String? input) async {
        setState(() {
          emailAddressErrorMsg = widget.validateEmailAddress(input);
        });
      },
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds password field
  Widget buildPasswordField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: passwordController,
      labelStr: AppLocalizations.of(context)!.passwordFieldLabel,
      hintStr: "",
      textInputAction: TextInputAction.next,
      isTextObscure: true,
      errorMsg: passwordErrorMsg,
      handleOnSubmitted: (String? input) async {
        setState(() {
          passwordErrorMsg = widget.validatePassword(input);
        });
      },
    );
  }


  /// It builds the sign up prompt
  Widget buildSignUpPrompt() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.youDoNotHaveAccount,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
              color: Theme.of(context).colorScheme.onBackground
          ),
        ),
        SizedBox(width: 5),
        GestureDetector(
            onTap: () => Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.signUp)),
            child: Text(
              AppLocalizations.of(context)!.signUp,
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
              ),
            )
        )
      ],
    );
  }

  /// It handles clicking sign up by validating the inputs once more for calling
  /// Screen method handleSubmitValidateInput.
  Future<void> handleSubmit() async {
    // validate the fields first.
    bool areValid = true;
    setState(() {
      emailAddressErrorMsg = widget.validateEmailAddress(emailAddressController.text);
    });
    areValid = areValid && emailAddressErrorMsg == null;
    setState(() {
      passwordErrorMsg = widget.validatePassword(passwordController.text);
    });
    areValid = areValid && passwordErrorMsg == null;

    if (areValid) {
      widget.handleSubmitSignIn(emailAddress: emailAddressController.text, password: passwordController.text);
    }
  }

}