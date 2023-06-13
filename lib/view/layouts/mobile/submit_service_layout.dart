import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/data/enums/electrician_issue_category_enum.dart';
import 'package:vaea_mobile/view/formatters/service_type_formatter.dart';
import 'package:vaea_mobile/view/widgets/cards/service_request_card.dart';
import 'package:vaea_mobile/view/widgets/containers/confirmation_message_container.dart';
import 'package:vaea_mobile/view/widgets/forms/electrician_form.dart';
import 'package:vaea_mobile/view/widgets/forms/house_cleaning_form.dart';
import 'package:vaea_mobile/view/widgets/forms/plumbing_form.dart';

import '../../../data/enums/plumbing_issue_category_enum.dart';
import '../../../data/enums/room_name_eunm.dart';
import '../../../data/enums/service_type_enum.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';

/// It handles the ui appearance and user interaction for SubmitRequestScreen.
class SubmitServiceLayout extends StatefulWidget {

  String? Function(DateTime? input) validatePreferredDate;
  String? Function(dynamic input) validateDropdownField;
  String? Function(String? input) validateDescription;
  String? Function(String? input) validateNotes;

  Future<int> Function({ required DateTime preferredDate, required String? notes }) handleSubmitCleaningService;
  Future<int> Function({
    required DateTime preferredDate,
    required RoomNameEnum selectedRoom,
    required PlumbingIssueCategoryEnum selectedCategory,
    required String description,
    required String? notes
  }) handleSubmitPlumbingService;
  Future<int> Function({
  required DateTime preferredDate,
  required RoomNameEnum selectedRoom,
  required ElectricianIssueCategoryEnum selectedCategory,
  required String description,
  required String? notes
  }) handleSubmitElectricianService;

  void Function() handleClickFinish;

  SubmitServiceLayout({
    super.key,
    required this.validatePreferredDate,
    required this.validateDropdownField,
    required this.validateDescription,
    required this.validateNotes,
    required this.handleSubmitCleaningService,
    required this.handleSubmitPlumbingService,
    required this.handleSubmitElectricianService,
    required this.handleClickFinish,
  });

  @override
  State<SubmitServiceLayout> createState() => _SubmitServiceLayoutState();
}

class _SubmitServiceLayoutState extends State<SubmitServiceLayout> {

  int currStep = 0; // steps are 0 selecting type, 1 filling data, 2 confirmation
  bool isLoading = false;
  int submittedRequestId = -1;
  ServiceTypeEnum? selectedServiceType;

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;
  final coastController = CoastController();

  // dimensions
  late double bodyPadding;
  late double serviceTypeSpacing;

  /// It is a helper method for build. It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      bodyPadding = layoutConstraints.maxWidth * 0.04;
      serviceTypeSpacing = layoutConstraints.maxWidth * 0.06;
    } else if (breakpoint.device.name == "mediumHandset") {
      bodyPadding = layoutConstraints.maxWidth * 0.04;
      serviceTypeSpacing = layoutConstraints.maxWidth * 0.06;
    } else {
      bodyPadding = layoutConstraints.maxWidth * 0.04;
      serviceTypeSpacing = layoutConstraints.maxWidth * 0.06;
    }
  }


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        breakpoint = Breakpoint.fromConstraints(constraints);
        layoutConstraints = constraints;
        setupDimensions();

        return WillPopScope(
          onWillPop: () async {
            if (currStep == 0 || currStep == 2) {
              return true;
            } else {
              setState(() { currStep = currStep - 1; });
              coastController.animateTo(beach: currStep);
              return false;
            }
          },
          child: Scaffold(
            appBar: AdaptiveTopAppBar(
              currPageTitle: AppLocalizations.of(context)!.addingRequest,
              previousPageTitle: "",
              breakpoint: breakpoint,
              layoutConstraints: constraints,
            ),
            body: Coast(
              controller: coastController,
              beaches: [
                buildTypeSelectionBeach(),
                buildSubmissionFormBeach(),
                buildConfirmationSection(context)
              ],
              observers: [ CrabController(), ],
              physics: const NeverScrollableScrollPhysics(),
            ),
          ),
        );
      },
    );
  }


  /// It builds the first beach/pageView that lets the user selects a service type.
  Beach buildTypeSelectionBeach() {
    return Beach(builder: (context) {
      return Padding(
        padding: EdgeInsets.all(bodyPadding),
        child: Wrap(
          direction: Axis.horizontal,
          alignment: WrapAlignment.spaceBetween,
          runAlignment: WrapAlignment.start,
          runSpacing: serviceTypeSpacing,
          children: ServiceTypeEnum.values.map((e) => ServiceRequestCard(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: handleClickServiceType,
            serviceType: e)).toList(),
        ),
      );
    });
  }


  /// It builds the second beach/pageView that lets the user fill the information.
  Beach buildSubmissionFormBeach() {
    return Beach(
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageSection(),
              (isLoading) ? const CircularProgressIndicator.adaptive() : Padding(
                padding: EdgeInsets.all(bodyPadding),
                child: buildFormSection(),
              ),
            ],
          ),
        );
      },
    );
  }


  /// It is a helper method for buildSubmissionFormBeach. It builds the request type image.
  Widget buildImageSection() {
    return Crab(
      tag: selectedServiceType!.toString(),
      child: Image.asset(
        ServiceTypeFormatter.getImagePath(selectedServiceType!),
        width: layoutConstraints.maxWidth,
        fit: BoxFit.fitWidth,
      )
    );
  }


  /// It is a helper method for buildSubmissionFormBeach. It builds the selected service's form
  Widget buildFormSection() {
    switch (selectedServiceType!) {
      case ServiceTypeEnum.cleaning:
        return HouseCleaningForm(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          validatePreferredDate: widget.validatePreferredDate,
          validateNotes: widget.validateNotes,
          handleSubmitHouseCleaningForm: handleSubmitCleaningHouseForm
        );
      case ServiceTypeEnum.plumber:
        return PlumbingForm(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          validatePreferredDate: widget.validatePreferredDate,
          validateDropdownField: widget.validateDropdownField,
          validateDescription: widget.validateDescription,
          validateNotes: widget.validateNotes,
          handleSubmitPlumbingForm: handleSubmitPlumbingForm
        );
      default: //case ServiceTypeEnum.electrician:
        return ElectricianForm(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          validatePreferredDate: widget.validatePreferredDate,
          validateDropdownField: widget.validateDropdownField,
          validateDescription: widget.validateDescription,
          validateNotes: widget.validateNotes,
          handleSubmitElectricianForm: handleSubmitElectricityForm
        );
    }
  }


  /// It builds the thrid beach/pageView that shows the submission confirmation.
  Beach buildConfirmationSection(BuildContext context) {
    String titleMsg;
    switch (selectedServiceType) {
      case ServiceTypeEnum.cleaning:
        titleMsg = AppLocalizations.of(context)!.houseCleaningOrderNum;
        break;
      case ServiceTypeEnum.plumber:
        titleMsg = AppLocalizations.of(context)!.plumbingOrderNum;
        break;
      default: //case ServiceTypeEnum.electrician:
        titleMsg = AppLocalizations.of(context)!.electricianOrderNum;
    }
    titleMsg += " $submittedRequestId " + AppLocalizations.of(context)!.hasBeenSubmitted;

    return Beach(
      builder: (context) => ConfirmationMessageContainer(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        titleMessage: titleMsg,
        subTitleMessage: AppLocalizations.of(context)!.vaeaAgentWillContact,
        actionButtonTitle: AppLocalizations.of(context)!.finish,
        handleClickActionButton: widget.handleClickFinish
      ),
    );
  }

  /// It makes the transition to the next beach/pageView.
  void handleClickServiceType(ServiceTypeEnum serviceType) {
    setState(() {
      selectedServiceType = serviceType;
      currStep = 1;
    });
    coastController.animateTo(beach: 1);
  }


  /// It handles the event of submitting the house cleaning form.
  Future<bool> handleSubmitCleaningHouseForm({ required DateTime preferredDate, required String? notes }) async {
    setState(() { isLoading = true; });

    int? requestID = await widget.handleSubmitCleaningService(preferredDate: preferredDate, notes: notes);
    if (requestID == -1) {
      setState(() { isLoading = true; });
      return false;
    }

    setState(() {
      isLoading = false;
      currStep = 2;
      submittedRequestId = requestID!;
    });
    coastController.animateTo(beach: 2);
    return true;
  }


  /// It handles the event of submitting the plumbing form.
  Future<bool> handleSubmitPlumbingForm({
    required DateTime preferredDate,
    required RoomNameEnum selectedRoom,
    required PlumbingIssueCategoryEnum selectedCategory,
    required String description,
    required String? notes
  }) async {

    setState(() { isLoading = true; });

    int? requestId = await widget.handleSubmitPlumbingService(
      preferredDate: preferredDate,
      selectedRoom: selectedRoom,
      selectedCategory: selectedCategory,
      description: description,
      notes: notes
    );
    if (requestId == -1) {
      setState(() { isLoading = true; });
      return false;
    }

    setState(() {
      isLoading = false;
      currStep = 2;
      submittedRequestId = requestId;
    });
    coastController.animateTo(beach: 2);
    return true;
  }


  /// It handles the event of submitting the electricity form.
  Future<bool> handleSubmitElectricityForm({
    required DateTime preferredDate,
    required RoomNameEnum selectedRoom,
    required ElectricianIssueCategoryEnum selectedCategory,
    required String description,
    required String? notes
  }) async {

    setState(() { isLoading = true; });

    int? requestId = await widget.handleSubmitElectricianService(
        preferredDate: preferredDate,
        selectedRoom: selectedRoom,
        selectedCategory: selectedCategory,
        description: description,
        notes: notes
    );
    if (requestId == -1) {
      setState(() { isLoading = true; });
      return false;
    }

    setState(() {
      isLoading = false;
      currStep = 2;
      submittedRequestId = requestId;
    });
    coastController.animateTo(beach: 2);
    return true;
  }


}