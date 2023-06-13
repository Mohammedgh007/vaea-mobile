
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/electrician_issue_category_enum.dart';
import 'package:vaea_mobile/view/formatters/electrician_issue_category_formatter.dart';
import 'package:vaea_mobile/view/formatters/room_name_formatter.dart';
import 'package:vaea_mobile/view/widgets/fields/date_picker_field.dart';
import 'package:vaea_mobile/view/widgets/fields/dropdown_field.dart';
import 'package:vaea_mobile/view/widgets/fields/text_field.dart';

import '../../../data/enums/room_name_eunm.dart';
import '../buttons/primary_button.dart';

/// It builds, validates, and manages the electrician form in SubmitServiceLayout.
class ElectricianForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  String? Function(DateTime? input) validatePreferredDate;
  String? Function(dynamic input) validateDropdownField;
  String? Function(String? input) validateDescription;
  String? Function(String? input) validateNotes;

  Future<bool> Function({
  required DateTime preferredDate,
  required RoomNameEnum selectedRoom,
  required ElectricianIssueCategoryEnum selectedCategory,
  required String description,
  required String? notes
  }) handleSubmitElectricianForm;

  ElectricianForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.validatePreferredDate,
    required this.validateDropdownField,
    required this.validateDescription,
    required this.validateNotes,
    required this.handleSubmitElectricianForm
  });


  @override
  State<ElectricianForm> createState() => _ElectricianFormState();
}

class _ElectricianFormState extends State<ElectricianForm> {

  // inputs
  DateTime? selectedPreferredDate;
  RoomNameEnum? selectedRoom;
  ElectricianIssueCategoryEnum? selectedCategory;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  // error message
  String? preferredDateErrorMsg;
  String? selectedRoomErrorMsg;
  String? selectedCategoryErrorMsg;
  String? descriptionErrorMsg;
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
        buildRoomField(),
        AnimatedSize(
          duration: const Duration(milliseconds: 400),
          curve: Curves.bounceInOut,
          child: Column(
            children: [
              if (selectedRoom != null) SizedBox(height: fieldsSpacer),
              if (selectedRoom != null) buildCategoryField(),
            ],
          ),
        ),
        SizedBox(height: fieldsSpacer),
        buildDescriptionField(),
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


  /// It builds the field of room.
  Widget buildRoomField() {
    return VAEADropdownField<RoomNameEnum>(
        breakpoint: widget.breakpoint,
        layoutConstraints: widget.layoutConstraints,
        handleChange: handleSelectRoom,
        options: RoomNameFormatter.getElectricianRoomsList(context),
        optionsValues: RoomNameFormatter.getElectricianRoomsVal(),
        errorMsg: selectedRoomErrorMsg,
        labelStr: AppLocalizations.of(context)!.roomLabel,
        hintStr: AppLocalizations.of(context)!.roomHint
    );
  }


  /// It builds the field of categories.
  /// @pre-condition a room has been selected.
  Widget buildCategoryField() {
    return VAEADropdownField<ElectricianIssueCategoryEnum>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      handleChange: (selected) => setState(() {
        selectedCategory = selected;
      }),
      currValue: selectedCategory,
      options: ElectricianIssueCategoryFormatter.getCategoriesList(context, selectedRoom!),
      optionsValues: ElectricianIssueCategoryFormatter.getCategoriesVal(selectedRoom!),
      errorMsg: selectedCategoryErrorMsg,
      labelStr: AppLocalizations.of(context)!.categoryTypeLabel,
      hintStr: AppLocalizations.of(context)!.categoryTypeHint,
    );
  }


  /// It builds the description fields
  Widget buildDescriptionField() {
    return VAEATextField(
        breakpoint: widget.breakpoint,
        layoutConstraints: widget.layoutConstraints,
        controller: descriptionController,
        labelStr: AppLocalizations.of(context)!.issueDescriptionLabel,
        hintStr: AppLocalizations.of(context)!.issueDescriptionHint,
        minLinesNum: 4,
        errorMsg: descriptionErrorMsg,
        textInputAction: TextInputAction.newline,
        isTextObscure: false
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


  /// It handles selecting a room name.
  void handleSelectRoom(RoomNameEnum? selectedRoom) {
    setState(() {
      this.selectedRoom = selectedRoom;
      selectedCategory = null;
    });
  }


  /// It handles clicking sign up by validating the inputs once more for calling
  /// Screen method handleSubmitValidateInput.
  void handleSubmit() {
    bool isValid = validateAllFields();

    if (isValid) {
      widget.handleSubmitElectricianForm(
          preferredDate: selectedPreferredDate!,
          selectedRoom: selectedRoom!,
          selectedCategory: selectedCategory!,
          description: descriptionController.text,
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
      selectedRoomErrorMsg = widget.validateDropdownField(selectedRoom);
    });
    areValid = areValid && selectedRoomErrorMsg == null;

    setState(() {
      selectedCategoryErrorMsg = widget.validateDropdownField(selectedCategory);
    });
    areValid = areValid && selectedCategoryErrorMsg == null;

    setState(() {
      descriptionErrorMsg = widget.validateDescription(descriptionController.text);
    });
    areValid = areValid && descriptionErrorMsg == null;

    setState(() {
      notesErrorMsg = widget.validateNotes(notesController.text);
    });
    areValid = areValid && notesErrorMsg == null;



    return areValid;
  }

}