
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';
import 'package:vaea_mobile/data/enums/lease_period_enum.dart';
import 'package:vaea_mobile/view/widgets/fields/date_picker_field.dart';
import 'package:vaea_mobile/view/widgets/fields/radio_btn_field.dart';
import 'package:vaea_mobile/view/widgets/forms/payment_form.dart';
import 'package:vaea_mobile/view/widgets/vaea_ui/vaea_horizontal_stepper.dart';
import 'package:vaea_mobile/view/widgets/vaea_ui/vaea_policy_checkbox.dart';

import '../../../data/enums/payment_provider_enum.dart';
import '../../../data/model/home_details_model.dart';
import '../../formatters/district_formatter.dart';
import '../../formatters/floor_formatter.dart';
import '../../widgets/buttons/primary_button.dart';
import '../../widgets/buttons/secondary_button.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';

/// It handles the ui interaction for BookingScreen
class BookingMobileLayout extends StatefulWidget {

  HomeDetailsModel listingModel;
  Future<bool> Function({
  required PaymentProviderEnum paymentProvider,
  required String paymentId,
  required LeasePeriodEnum leasePeriodType,
  required DateTime startingDate,
  required DateTime endingDate
  }) handleConfirmBooking;
  BookingMobileLayout({
    super.key,
    required this.listingModel,
    required this.handleConfirmBooking
  });

  @override
  State<BookingMobileLayout> createState() => _BookingMobileLayoutState();
}

class _BookingMobileLayoutState extends State<BookingMobileLayout> {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;
  int currStep = 0;
  bool isLoading = false;

  // dimensions
  late double btnWidth;
  late double sectionsSpacer;
  late double titleSpacer;
  late double bodyTextSpacer;
  late double mapViewHeight;
  late double mapViewWidth;

  // period inputs
  LeasePeriodEnum selectedPeriod = LeasePeriodEnum.months3;
  DateTime? selectedStartingDate;
  String? startingDateErrorMsg;
  /// It is based on selectedPeriod and selectedStartingDate
  DateTime? selectedEndDate;
  bool hasCheckedAgreedOnRefundPolicy = false;


  /// It is a helper method for build(). It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.44;
      sectionsSpacer = layoutConstraints.maxHeight * 0.038;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      mapViewWidth = layoutConstraints.maxWidth;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnWidth = layoutConstraints.maxWidth * 0.44;
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      mapViewWidth = layoutConstraints.maxWidth;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else {
      btnWidth = layoutConstraints.maxWidth * 0.44;
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      mapViewWidth = layoutConstraints.maxWidth;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    }
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      breakpoint = Breakpoint.fromConstraints(constraints);
      layoutConstraints = constraints;
      setupDimensions();

      return Scaffold(
        appBar: AdaptiveTopAppBar(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          previousPageTitle: AppLocalizations.of(context)!.homeDetails,
          currPageTitle: AppLocalizations.of(context)!.booking
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildStepper(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: layoutConstraints.maxWidth * 0.04, vertical: layoutConstraints.maxHeight * 0.03),
                child: buildNthStepContent(),
              )
            ),
            buildActionBtns(),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 10)
          ],
        ),
      );
      }
    );
  }


  /// It builds the stepper section as a header.
  Widget buildStepper() {
    return (currStep == 3) ? SizedBox() : VAEAStepper(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      stepsNames: [
        AppLocalizations.of(context)!.leasePeriod,
        AppLocalizations.of(context)!.confirmation,
        AppLocalizations.of(context)!.payment
      ],
        currStep: currStep
    );
  }


  /// It builds the stepper body content.
  Widget buildNthStepContent() {
    switch(currStep) {
      case 0: // Lease period
        return buildLeasePeriodStep();
      case 1:
        return buildConfirmationStep();
      case 2:
        return buildPaymentSection();
      default: // confirming the booking success
        return buildSuccessMessage();
    }
  }


  /// It builds the step of lease period
  Widget buildLeasePeriodStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VAEARadioBtnField<LeasePeriodEnum>(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          labelStr: AppLocalizations.of(context)!.leasePeriod,
          options: [
            AppLocalizations.of(context)!.period3Months,
            AppLocalizations.of(context)!.period6Months,
            AppLocalizations.of(context)!.period12Months
          ],
          optionsVal: [
            LeasePeriodEnum.months3,
            LeasePeriodEnum.months6,
            LeasePeriodEnum.months12
          ],
          selected: selectedPeriod,
          handleSelect: (selected) {
            setState(() {
              selectedPeriod = selected;
            });
          }
        ),
        SizedBox(height: layoutConstraints.maxHeight * 0.03),
        VAEADatePickerField(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          selectedDate: selectedStartingDate,
          initialDate: DateTime.now().add(Duration(days: 3)),
          firstDate: DateTime.now().add(Duration(days: 3)),
          lastDate: DateTime.now().add(Duration(days: 25)),
          labelStr: AppLocalizations.of(context)!.startingDateOfResume,
          hintStr: AppLocalizations.of(context)!.selectWhenToStartLease,
          errorMsg: startingDateErrorMsg,
          handleOnSubmitted: (DateTime selected) => setState(() {
            selectedStartingDate = selected;
            if (selectedPeriod == LeasePeriodEnum.months3) {
              selectedEndDate = DateTime(selectedStartingDate!.year, selectedStartingDate!.month + 3, selectedStartingDate!.day);
            } else if (selectedPeriod == LeasePeriodEnum.months6) {
              selectedEndDate = DateTime(selectedStartingDate!.year, selectedStartingDate!.month + 6, selectedStartingDate!.day);
            } else {
              selectedEndDate = DateTime(selectedStartingDate!.year + 1, selectedStartingDate!.month, selectedStartingDate!.day);
            }
          }),
        )
      ],
    );
  }


  /// It builds the step that lists the required information
  Widget buildConfirmationStep() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildContractSection(),
          SizedBox(height: sectionsSpacer),
          buildApartmentDetails(),
          SizedBox(height: sectionsSpacer),
          buildLocationSection(),
          SizedBox(height: sectionsSpacer),
          VAEAPolicyCheckBox(
            prePolicyNameText: AppLocalizations.of(context)!.byCheckingHere,
            policyNameText: " ${AppLocalizations.of(context)!.refundPolicy}",
            postPolicyNameText: AppLocalizations.of(context)!.refundPolicyThat,
            hasChecked: hasCheckedAgreedOnRefundPolicy,
            handleChangeHasChanged: (bool isChecked) => setState(() => hasCheckedAgreedOnRefundPolicy = isChecked)
          )

        ],
      ),
    );
  }


  /// It builds the section that lists the apartment type, start date, and end date
  Widget buildContractSection() {
    String homeTypeText = (widget.listingModel.listingType == HomeType.shared)
      ? AppLocalizations.of(context)!.sharedHomeTitle
      : AppLocalizations.of(context)!.entireHomeTitle;
    String MoveInDateText = AppLocalizations.of(context)!.moveInDate + " " + DateFormat("yyyy-MM-dd").format(selectedStartingDate!);
    String MoveOutDateText = AppLocalizations.of(context)!.moveOutDate + " " + DateFormat("yyyy-MM-dd").format(selectedEndDate!);

    return buildTextSection(
        AppLocalizations.of(context)!.unitDetails,
        [ homeTypeText, MoveInDateText, MoveOutDateText ],
        null
    );
  }

  /// it builds the apartment details section
  Widget buildApartmentDetails() {
    String bedroomText = (widget.listingModel.bedrooms == 1)
        ? "${AppLocalizations.of(context)!.bedroom} ${widget.listingModel.bedrooms}"
        : "${AppLocalizations.of(context)!.bedrooms} ${widget.listingModel.bedrooms}";
    String bathroomText = (widget.listingModel.bathrooms == 1)
        ? "${AppLocalizations.of(context)!.bathroom} ${widget.listingModel.bathrooms}"
        : "${AppLocalizations.of(context)!.bathrooms} ${widget.listingModel.bathrooms}";
    String roomText = "${bedroomText} / ${bathroomText}";
    String areaText = "${widget.listingModel.area} ${AppLocalizations.of(context)!.mUnit}";
    String floorText = FloorFormatter.mapEnumToText(context, widget.listingModel.floor);

    return buildTextSection(
        AppLocalizations.of(context)!.unitDetails,
        [ roomText, areaText, floorText ],
        null
    );
  }

  /// It builds the location section.
  Widget buildLocationSection() {
    String districtText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.districtLabel} ${DistrictFormatter.mapEnumToText(context, widget.listingModel.district)}"
        : "${DistrictFormatter.mapEnumToText(context, widget.listingModel.district)} ${AppLocalizations.of(context)!.districtLabel}";
    String streetText = (AppLocalizations.of(context)!.localeName == "ar")
        ? "${AppLocalizations.of(context)!.street} ${widget.listingModel.street}"
        : "${widget.listingModel.street} ${AppLocalizations.of(context)!.street}";
    String buildText = "${AppLocalizations.of(context)!.building} ${widget.listingModel.buildingId}";

    return buildTextSection(
        AppLocalizations.of(context)!.location,
        [ districtText, streetText, buildText ],
        buildGoogleMapView()
    );
  }

  /// It is a helper method. It builds a section title with its info.
  Widget buildTextSection(String title, List<String> lines, Widget? map) {
    List<Widget> spacedLines = [
      Text(
        title,
        style: TextStyle(
            fontSize: Theme.of(context)!.textTheme.headlineMedium!.fontSize
        ),
      ),
      SizedBox(height: titleSpacer)
    ];


    for (int i = 0; i < lines.length; i++) {
      spacedLines.add( Text(
        lines[i],
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
        ),
      ));

      if (i + 1 < lines.length)
        spacedLines.add(SizedBox(height: bodyTextSpacer));

    }

    if (map != null) {
      spacedLines.add(SizedBox(height: bodyTextSpacer * 2));
      spacedLines.add(map);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: spacedLines,
    );
  }

  /// It is a helper method for buildLocationSection.
  Widget buildGoogleMapView() {
    LatLng position = LatLng(widget.listingModel.lat, widget.listingModel.lon);
    return SizedBox(
      width: mapViewWidth,
      height: mapViewHeight,
      child: GoogleMap(
        onTap: (_) => MapsLauncher.launchCoordinates(position.latitude, position.longitude),
        mapType: MapType.normal,
        markers: {Marker(markerId: MarkerId("market"), position: position)},
        initialCameraPosition: CameraPosition(
          zoom: 15.0,
          target: position
        )
      ),
    );
  }


  /// It builds the successive of finalizing booking
  Widget buildSuccessMessage() {
    return Container(
      alignment: Alignment.center,
      width: layoutConstraints.maxWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Theme.of(context).colorScheme.secondary,
            size: layoutConstraints.maxWidth * 0.7,
          ),
          Text(
            "تم حجز المنزل",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme!.headlineMedium!.fontSize,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "سيتم ارسال عقد ايجار الى بريدك الإلكروني في ثواني",
            style: TextStyle(
              fontSize: Theme.of(context).textTheme!.bodyLarge!.fontSize,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
          ),
          SizedBox(height: 20),
          PrimaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: () {},
            buttonText: "إنهاء"
          )
        ],
      ),
    );
  }


  /// It builds payment section
  Widget buildPaymentSection() { // TODO
    int amount = 0;
    if (selectedPeriod == LeasePeriodEnum.months3) {
      amount = widget.listingModel.price * 3;
    } else if (selectedPeriod == LeasePeriodEnum.months6) {
      amount = widget.listingModel.price * 6;
    } else {
      amount = widget.listingModel.price * 12;
    }

    return PaymentForm(
      handleSubmit: (PaymentProviderEnum paymentProvider, String paymentId) {
        handleSubmit(paymentProvider, paymentId);
      },
      amount: amount,
    );
  }

  /// It builds the bottom row of action buttons
  Widget buildActionBtns() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: layoutConstraints.maxWidth * 0.04),
      child: (currStep == 3) ? SizedBox() : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SecondaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: (currStep == 0)
              ? handleClickCancel
              : handleClickPrevious,
            buttonText: (currStep == 0)
              ? AppLocalizations.of(context)!.cancel
              : AppLocalizations.of(context)!.previous,
            width: btnWidth,
          ),
          if (currStep != 2) PrimaryBtn(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClick: handleClickNext,
            buttonText: AppLocalizations.of(context)!.next,
            width: btnWidth,
          )
        ],
      ),
    );
  }


  /// It handles the event of clicking next.
  void handleClickNext() {
    // validate that the inputs are not empty
    if (currStep == 0) {
      if (selectedStartingDate == null) {
        setState(() {
          startingDateErrorMsg = AppLocalizations.of(context)!.requiredFieldErrorMsg;
        });
        return;
      } else {
        setState(() {
          startingDateErrorMsg = null;
        });
      }
    } else if (currStep == 1 && !hasCheckedAgreedOnRefundPolicy) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.pleaseCheckRefundPolicy),
      ));
      return;
    }

    // let the user progress
    setState(() {
      currStep += 1;
    });
  }


  /// It handles the event of submitting through clicking pay.
  void handleSubmit(PaymentProviderEnum paymentProvider, String paymentId) async {
    setState(() => isLoading = true);
    bool hasSuccess = await widget.handleConfirmBooking(paymentProvider: paymentProvider,
      paymentId: paymentId, startingDate: selectedStartingDate!, endingDate: selectedEndDate!, leasePeriodType: selectedPeriod);
    if (hasSuccess) {
      setState(() => currStep = 3 );
    }
    setState(() => isLoading = false);

  }


  /// It handles the event of clicking cancel.
  void handleClickCancel() {
    Navigator.of(context).pop();
  }

  /// It handles the event of clicking previous
  void handleClickPrevious() {
    setState(() {
      currStep = currStep - 1;
    });
  }

}