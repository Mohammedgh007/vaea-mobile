
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/fields/date_picker_field.dart';
import 'package:vaea_mobile/view/widgets/fields/text_field.dart';

import '../buttons/primary_button.dart';

/// It builds, validates, and manages the house cleaning form in SubmitServiceLayout.
class HouseCleaningForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  String? Function(DateTime? input) validatePreferredDate;
  String? Function(String? input) validateNotes;
  Future<bool> Function({
    required DateTime preferredDate,
    required String? notes
  }) handleSubmitHouseCleaningForm;

  HouseCleaningForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validatePreferredDate,
    required this.validateNotes,
    required this.handleSubmitHouseCleaningForm
  });


  @override
  State<HouseCleaningForm> createState() => _HouseCleaningFormState();
}

class _HouseCleaningFormState extends State<HouseCleaningForm> {

  // inputs
  DateTime? selectedPreferredDate;
  TextEditingController notesController = TextEditingController();

  // error message
  String? preferredDateErrorMsg;
  String? notesErrorMsg;

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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildSeparatedFields(),
          SizedBox(height: fieldsBtnSpacer),
          PrimaryBtn(
            breakpoint: widget.breakpoint,
            layoutConstraints: widget.layoutConstraints,
            handleClick: handleSubmit,
            buttonText: AppLocalizations.of(context)!.submitRequest
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
        buildPreferredDateField(),
        SizedBox(height: fieldsSpacer),
        buildNotesField(),
      ],
    );
  }


  /// It builds the date field for selecting the preferred date of appointment
  Widget buildPreferredDateField() {
    DateTime afterOneWeek = DateTime.now().add(const Duration(days: 7));

    return VAEADatePickerField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      selectedDate: selectedPreferredDate,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: afterOneWeek,
      labelStr: AppLocalizations.of(context)!.preferredDayOfVisit,
      hintStr: AppLocalizations.of(context)!.selectPreferredDayOfVisit,
      errorMsg: preferredDateErrorMsg,
      handleOnSubmitted: (DateTime selected) {
        String? errorMsg = widget.validatePreferredDate(selected);
        DateTime now = DateTime.now();
        setState(() {
          selectedPreferredDate = now.copyWith(year: selected.year, month: selected.month, day: selected.day);
          preferredDateErrorMsg = errorMsg;
        });
      }
    );
  }


  /// It builds the notes fields
  Widget buildNotesField() {
    return VAEATextField(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      controller: notesController,
      labelStr: AppLocalizations.of(context)!.notesOptionalLabel,
      hintStr: AppLocalizations.of(context)!.notesOptionalHint,
      errorMsg: notesErrorMsg,
      textInputAction: TextInputAction.done,
      isTextObscure: false
    );
  }


  /// It handles clicking sign up by validating the inputs once more for calling
  /// Screen method handleSubmitValidateInput.
  void handleSubmit() {
    bool isValid = validateAllFields();

    if (isValid) {
      widget.handleSubmitHouseCleaningForm(
        preferredDate: selectedPreferredDate!,
        notes: notesController.text
      );
    }
  }


  /// It is a helper method for handleSubmit. It validates all the fields.
  /// @returns true if all fields are valid
  bool validateAllFields() {
    bool areValid = true;

    setState(() {
      preferredDateErrorMsg = widget.validatePreferredDate(selectedPreferredDate);
    });
    areValid = areValid && preferredDateErrorMsg == null;

    setState(() {
      notesErrorMsg = widget.validateNotes(notesController.text);
    });
    areValid = areValid && notesErrorMsg == null;
    debugPrint("ddd ${widget.validatePreferredDate(selectedPreferredDate)} ${widget.validateNotes(notesController.text)}");

    return areValid;
  }

}