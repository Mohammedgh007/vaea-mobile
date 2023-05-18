
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';
import '../fields/dropdown_field.dart';

/// It builds a modal for selecting the app language. In mobile it is a bottom sheet.
class LanguageModal extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  /// It must be either ar or en
  String preSelectedLanguage;
  void Function(String selectedLanguage) handleChangeLanguage;

  LanguageModal({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.preSelectedLanguage,
    required this.handleChangeLanguage
  });

  @override
  State<LanguageModal> createState() => _LanguageModalState();
}

class _LanguageModalState extends State<LanguageModal> {

  String? selectedLanguage;

  // dimensions
  late double horizontalPadding;
  late double verticalPadding;
  late double btnWidth;


  @override
  void initState() {
    super.initState();

    setupDimensions();
  }


  /// It is a helper method for initState(). It initializes the dimensions fields.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      horizontalPadding = widget.layoutConstraints.maxWidth * 0.035;
      verticalPadding = widget.layoutConstraints.maxHeight * 0.05;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      horizontalPadding = widget.layoutConstraints.maxWidth * 0.035;
      verticalPadding = widget.layoutConstraints.maxHeight * 0.05;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else {
      horizontalPadding = widget.layoutConstraints.maxWidth * 0.035;
      verticalPadding = widget.layoutConstraints.maxHeight * 0.05;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.only(
        top: verticalPadding,
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: verticalPadding
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDropDown(),
          buildActionsBtn()
        ],
      ),
    );
  }


  /// It builds the dropdown field for the language options.
  Widget buildDropDown() {
    return VAEADropdownField<String>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      handleChange: (String? selected) => selectedLanguage = selected,
      options: [
        AppLocalizations.of(context)!.arabic,
        AppLocalizations.of(context)!.english
      ],
      optionsValues: const ["ar", "en"],
      labelStr: AppLocalizations.of(context)!.language,
      hintStr: AppLocalizations.of(context)!.selectLanguage
    );
  }


  /// It builds the row of action buttons
  Widget buildActionsBtn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SecondaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: () => Navigator.of(context).pop(),
          buttonText: AppLocalizations.of(context)!.cancel,
          width: btnWidth,
        ),
        PrimaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: handleClickSave,
          buttonText: AppLocalizations.of(context)!.save,
          width: btnWidth,
        )
      ],
    );
  }


  /// It handles the event of clicking save button by checking the input then
  /// calling the parameter change language before closing the modal.
  void handleClickSave() {
    if (selectedLanguage != null) {
      widget.handleChangeLanguage(selectedLanguage!);
    }

    Navigator.pop(context);
  }

}