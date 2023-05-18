import "dart:io";
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';
import 'package:vaea_mobile/view/widgets/fields/dropdown_field.dart';
import 'package:vaea_mobile/view/widgets/fields/file_field.dart';
import 'package:vaea_mobile/view/widgets/fields/text_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/gender.dart';

/// It builds, validates, and manages the registration form in SignUpMobileLayout.
class RegistrationForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  String? Function(String? input) validateFirstName;
  String? Function(String? input) validateLastName;
  String? Function(Gender? input) validateGender;
  String? Function(File? input) validateProfileImage;
  String? Function(String? input) validateIDIqamaNumber;
  Future<String?> Function(String? input) validateEmailAddress;
  String? Function(String? input) validatePassword;
  String? Function(String? passwordInput, String? confirmPasswordInput) validateConfirmPassword;
  void Function({required String firstName, required String lastName, required Gender gender,
  required File? profileImage, required String idIqamaNumber, required String emailAddress,
  required String password}) handleSubmitRegistrationForm;

  RegistrationForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validateFirstName,
    required this.validateLastName,
    required this.validateGender,
    required this.validateProfileImage,
    required this.validateIDIqamaNumber,
    required this.validateEmailAddress,
    required this.validatePassword,
    required this.validateConfirmPassword,
    required this.handleSubmitRegistrationForm
  });


  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {

  // inputs
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  Gender? selectedGender;
  File? selectedProfileImage;
  TextEditingController idIqamaNumberController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  // error message
  String? firstNameErrorMsg;
  String? lastNameErrorMsg;
  String? genderErrorMsg;
  String? profileImageErrorMsg;
  String? idIqamaErrorMsg;
  String? emailAddressErrorMsg;
  String? passwordErrorMsg;
  String? confirmPasswordErrorMsg;

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
      fieldsBtnSpacer = fieldsSpacer * 2.5;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = fieldsSpacer * 2.5;
    } else {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      fieldsBtnSpacer = fieldsSpacer * 2.5;
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
            buttonText: AppLocalizations.of(context)!.signUp
          ),
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
        buildFirstNameField(),
        SizedBox(height: fieldsSpacer),
        buildLastNameField(),
        SizedBox(height: fieldsSpacer),
        buildGenderField(),
        SizedBox(height: fieldsSpacer),
        buildProfileImageField(),
        SizedBox(height: fieldsSpacer),
        buildIdIqamaField(),
        SizedBox(height: fieldsSpacer),
        buildEmailAddressField(),
        SizedBox(height: fieldsSpacer),
        buildPasswordField(),
        SizedBox(height: fieldsSpacer),
        buildConfirmPasswordField(),
      ],
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds firstName field
  Widget buildFirstNameField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: firstNameController,
      labelStr: AppLocalizations.of(context)!.firstnameFieldLabel,
      hintStr: AppLocalizations.of(context)!.firstNameFieldHint,
      textInputAction: TextInputAction.next,
      isTextObscure: false,
      errorMsg: firstNameErrorMsg,
      handleOnSubmitted: (String? input) async {
        setState(() {
          firstNameErrorMsg = widget.validateFirstName(input);
        });
      },
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds lastName field
  Widget buildLastNameField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: lastNameController,
      labelStr: AppLocalizations.of(context)!.lastNameFieldLabel,
      hintStr: AppLocalizations.of(context)!.lastNameFieldHint,
      textInputAction: TextInputAction.next,
      isTextObscure: false,
      errorMsg: lastNameErrorMsg,
      handleOnSubmitted: (String? input) async {
        setState(() {
          lastNameErrorMsg = widget.validateLastName(input);
        });
      },
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds gender field.
  Widget buildGenderField() {
    return VAEADropdownField<Gender>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      handleChange: (Gender? selected) {
        setState(() {
          selectedGender = selected;
          genderErrorMsg = widget.validateGender(selected);
        });
      },
      options: [AppLocalizations.of(context)!.male, AppLocalizations.of(context)!.female],
      optionsValues: const [Gender.male, Gender.female],
      labelStr: AppLocalizations.of(context)!.genderFieldLabel,
      hintStr: AppLocalizations.of(context)!.genderFieldHint,
      errorMsg: genderErrorMsg,
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds profile image field.
  Widget buildProfileImageField() {
    return VAEAFileField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      selectedFile: selectedProfileImage,
      handleSelectFile: (File selectedFile) {
        setState(() {
          selectedProfileImage = selectedFile;
        });
      },
      labelStr: AppLocalizations.of(context)!.profileImageFieldLabel,
      hintStr: AppLocalizations.of(context)!.profileImageFieldHint,
      errorMsg: profileImageErrorMsg,
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds id/iqama field
  Widget buildIdIqamaField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: idIqamaNumberController,
      labelStr: AppLocalizations.of(context)!.idIqamaFieldLabel,
      hintStr: AppLocalizations.of(context)!.idIqamaFieldHint,
      textInputAction: TextInputAction.next,
      isTextObscure: false,
      errorMsg: idIqamaErrorMsg,
      handleOnSubmitted: (String? input) async {
        String? errorMsg = await widget.validateIDIqamaNumber(input);
        setState(() {
          idIqamaErrorMsg = errorMsg;
        });
      },
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
        String? errorMsg = await widget.validateEmailAddress(input);
        setState(() {
          emailAddressErrorMsg = errorMsg;
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
        String? errorMsg = await widget.validatePassword(input);
        setState(() {
          passwordErrorMsg = errorMsg;
        });
      },
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds confirm password field
  Widget buildConfirmPasswordField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: confirmPasswordController,
      labelStr: AppLocalizations.of(context)!.confirmPasswordFieldLabel,
      hintStr: "",
      textInputAction: TextInputAction.done,
      handleOnSubmitted: (String? input) async {
        String? errorMsg = await widget.validateConfirmPassword(passwordController.text, input);
        setState(() {
          confirmPasswordErrorMsg = errorMsg;
        });


      },
      isTextObscure: true,
      errorMsg: confirmPasswordErrorMsg,
    );
  }


  /// It handles clicking sign up by validating the inputs once more for calling
  /// Screen method handleSubmitValidateInput.
  Future<void> handleSubmit() async {
    bool isValid = await validateAllFields();

    if (isValid) {
      widget.handleSubmitRegistrationForm(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: selectedGender!,
        profileImage: selectedProfileImage,
        idIqamaNumber: idIqamaNumberController.text,
        emailAddress: emailAddressController.text,
        password: passwordController.text
      );
    }
  }


  /// It is a helper method for handleSubmit. It validates all the fields.
  /// @returns true if all fields are valid
  Future<bool> validateAllFields() async {
    bool areValid = true;

    setState(() {
      firstNameErrorMsg = widget.validateFirstName(firstNameController.text);
    });
    areValid = areValid && firstNameErrorMsg == null;

    setState(() {
      lastNameErrorMsg = widget.validateLastName(lastNameController.text);
    });
    areValid = areValid && lastNameErrorMsg == null;

    setState(() {
      genderErrorMsg = widget.validateGender(selectedGender);
    });
    areValid = areValid && genderErrorMsg == null;

    setState(() {
      profileImageErrorMsg = widget.validateProfileImage(selectedProfileImage);
    });
    areValid = areValid && profileImageErrorMsg == null;

    setState(() {
      idIqamaErrorMsg = widget.validateIDIqamaNumber(idIqamaNumberController.text);
    });
    areValid = areValid && idIqamaErrorMsg == null;

    String? errorMsg = await widget.validateEmailAddress(emailAddressController.text);
    setState(() {
      emailAddressErrorMsg =errorMsg;
    });
    areValid = areValid && emailAddressErrorMsg == null;

    setState(() {
      passwordErrorMsg = widget.validatePassword(passwordController.text);
    });
    areValid = areValid && passwordErrorMsg == null;

    setState(() {
      confirmPasswordErrorMsg = widget.validateConfirmPassword(passwordController.text, confirmPasswordController.text);
    });
    areValid = areValid && confirmPasswordErrorMsg == null;

    return areValid;
  }

}