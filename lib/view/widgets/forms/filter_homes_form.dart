
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/district_enum.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';
import 'package:vaea_mobile/view/ui_events/closing_search_panel_event.dart';
import 'package:vaea_mobile/view/ui_events/ui_events_manager.dart';
import 'package:vaea_mobile/view/widgets/fields/dropdown_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../data/enums/city_name.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// It builds and manages the filtering form in HomeSearchMobileLayout.
class FilterHomesForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  HomeType defaultHomeType;
  CityName defaultCityName;

  void Function({
    required HomeType? selectedHomeType,
    required CityName? selectedCityName,
    required DistrictEnum? selectedDistrict,
    required int? bedrooms,
    required int? bathrooms
  }) handleSubmitFilterForm;

  FilterHomesForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleSubmitFilterForm,
    required this.defaultHomeType,
    required this.defaultCityName
  });

  @override
  State<FilterHomesForm> createState() => _FilterHomesFormState();
}

class _FilterHomesFormState extends State<FilterHomesForm> {

  late UiEventsManager uiEventsManager = UiEventsManager();
  
  // inputs
  HomeType? homeType;
  CityName? cityName;
  DistrictEnum? districtEnum;
  int? bedrooms;
  int? bathrooms;
  HomeType? submittedHomeType;
  CityName? submittedCityName;
  DistrictEnum? submittedDistrictEnum;
  int? submittedBedrooms;
  int? submittedBathrooms;

  // dimensions
  late double fieldsSpacer;
  late double btnWidth;


  @override
  void initState() {
    super.initState();

    setupDimensions();

    uiEventsManager.listenToClosingSearchPanelEvent((event) {
      resetFields();
    });
  }


  /// It is a helper method to initState. It setups the dimensions in the form.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    }
  }


  /// It resets the fields if the user has not submitted the filters.
  void resetFields() {
    homeType = (submittedHomeType != null) ? submittedHomeType : widget.defaultHomeType;
    cityName = (submittedCityName != null) ? submittedCityName : widget.defaultCityName;
    districtEnum = submittedDistrictEnum;
    bedrooms = submittedBathrooms;
    bathrooms = submittedBathrooms;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.layoutConstraints.maxWidth * 0.92,
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildSeparatedFields(),
            SizedBox(height: fieldsSpacer * 3),
            buildActionBtns(),
            SizedBox(height: fieldsSpacer * 2),
          ],
        ),
      ),
    );
  }

  /// It is a helper method. It builds the list of fields.
  Widget buildSeparatedFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildHomeTypeField(),
        SizedBox(height: fieldsSpacer),
        buildCityNameField(),
        SizedBox(height: fieldsSpacer),
        buildDistrictField(),
        SizedBox(height: fieldsSpacer),
        buildBedroomsField(),
        SizedBox(height: fieldsSpacer),
        buildBathroomsField()
      ],
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds the home type field.
  Widget buildHomeTypeField() {
    return VAEADropdownField<HomeType>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      handleChange: (HomeType? selected) {
        homeType = selected;
      },
      options: [
        AppLocalizations.of(context)!.entireHomeTitle,
        AppLocalizations.of(context)!.sharedHomeTitle
      ],
      optionsValues: [HomeType.private, HomeType.shared],
      currValue: (homeType != null) ? homeType : widget.defaultHomeType,
      labelStr: AppLocalizations.of(context)!.homeType,
      hintStr: null
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds the city name field.
  Widget buildCityNameField() {
    return VAEADropdownField<CityName>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      handleChange: (CityName? selected) {
        cityName = selected;
      },
      options: [
        AppLocalizations.of(context)!.riyadh,
        AppLocalizations.of(context)!.jeddah,
        AppLocalizations.of(context)!.khobar
      ],
      optionsValues: [CityName.riyadh, CityName.jeddah, CityName.khobar],
      currValue: (cityName != null) ? cityName : widget.defaultCityName,
      labelStr: AppLocalizations.of(context)!.city,
      hintStr: null
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds the district field.
  Widget buildDistrictField() {
    return VAEADropdownField<DistrictEnum?>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      handleChange: (DistrictEnum? selected) {
        districtEnum = selected;
      },
      options: [
        AppLocalizations.of(context)!.any,
        AppLocalizations.of(context)!.aqiq,
        AppLocalizations.of(context)!.malqa
      ],
      optionsValues: const [null, DistrictEnum.aqiqRuh, DistrictEnum.malqaRuh],
      labelStr: AppLocalizations.of(context)!.district,
      hintStr: null
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds the district field.
  Widget buildBedroomsField() {
    return VAEADropdownField<int?>(
        breakpoint: widget.breakpoint,
        layoutConstraints: widget.layoutConstraints,
        handleChange: (int? selected) {
          bedrooms = selected;
        },
        options: [
          AppLocalizations.of(context)!.any,
          "1",
          "2",
          "3"
        ],
        optionsValues: const [null, 1, 2, 3],
        labelStr: AppLocalizations.of(context)!.bedrooms,
        hintStr: null
    );
  }


  /// It is a helper method for buildSeparatedFields. It builds the district field.
  Widget buildBathroomsField() {
    return VAEADropdownField<int?>(
        breakpoint: widget.breakpoint,
        layoutConstraints: widget.layoutConstraints,
        handleChange: (int? selected) {
          bathrooms = selected;
        },
        options: [
          AppLocalizations.of(context)!.any,
          "1",
          "2",
          "3"
        ],
        optionsValues: const [null, 1, 2, 3],
        labelStr: AppLocalizations.of(context)!.bathrooms,
        hintStr: null
    );
  }

  /// It builds verify button and back button
  Widget buildActionBtns() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SecondaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: () => uiEventsManager.fireClosingSearchPanelEvent(ClosingSearchPanelEvent()),
          buttonText: AppLocalizations.of(context)!.cancel,
          width: btnWidth,
        ),
        PrimaryBtn(
          breakpoint: widget.breakpoint,
          layoutConstraints: widget.layoutConstraints,
          handleClick: () {
            handleSubmit();
            uiEventsManager.fireClosingSearchPanelEvent(ClosingSearchPanelEvent());
          },
          buttonText: AppLocalizations.of(context)!.search,
          width: btnWidth,
        )
      ],
    );
  }


  /// It handles submitting the form.
  void handleSubmit() {
    submittedHomeType = homeType;
    submittedCityName = cityName;
    submittedDistrictEnum = districtEnum;
    submittedBedrooms = bedrooms;
    submittedBathrooms = bathrooms;

    widget.handleSubmitFilterForm(
        selectedHomeType: (homeType != null) ? homeType : widget.defaultHomeType,
        selectedCityName: (cityName != null) ? cityName : widget.defaultCityName,
        selectedDistrict: districtEnum,
        bedrooms: bedrooms,
        bathrooms: bathrooms);
  }
}