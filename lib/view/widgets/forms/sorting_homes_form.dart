
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/fields/radio_btn_field.dart';

import '../../ui_events/closing_search_panel_event.dart';
import '../../ui_events/ui_events_manager.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

/// It builds and manages the sorting form in HomeSearchMobileLayout.
class SortingHomeForm extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  void Function(int option) handleSubmitSorting;

  SortingHomeForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleSubmitSorting
  });


  @override
  State<SortingHomeForm> createState() => _SortingHomeFormState();
}

class _SortingHomeFormState extends State<SortingHomeForm> {

  late UiEventsManager uiEventsManager;

  // inputs
  int selectedOption = 0; // 0 to 3
  int submittedOption = 0;

  // dimensions
  late double fieldsSpacer;
  late double btnWidth;


  @override
  void initState() {
    super.initState();

    setupDimensions();
    uiEventsManager = UiEventsManager();

    uiEventsManager.listenToClosingSearchPanelEvent((event) {
      setState(() {
        selectedOption = submittedOption;
      });
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


  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.layoutConstraints.maxWidth * 0.92,
      height: widget.layoutConstraints.maxHeight * 0.5,
      padding: EdgeInsets.only(bottom: fieldsSpacer),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildSortingOptions(),
          buildActionBtns(),
        ],
      ),
    );
  }


  /// It builds the label with the four options for sorting.
  Widget buildSortingOptions() {
    return VAEARadioBtnField<int>(
      breakpoint: widget.breakpoint,
      layoutConstraints: widget.layoutConstraints,
      labelStr: null,
      options: [
        AppLocalizations.of(context)!.pricesLowToHigh,
        AppLocalizations.of(context)!.pricesHighToLow,
        AppLocalizations.of(context)!.areasBigToSmall,
        AppLocalizations.of(context)!.areasSmallToBig
      ],
      optionsVal: [0, 1, 2, 3],
      selected: selectedOption,
      handleSelect: (int selected) {
        setState(() {
          selectedOption = selected;
        });
      },
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
            submittedOption = selectedOption;
            widget.handleSubmitSorting(selectedOption);
            uiEventsManager.fireClosingSearchPanelEvent(ClosingSearchPanelEvent());
          },
          buttonText: AppLocalizations.of(context)!.search,
          width: btnWidth,
        )
      ],
    );
  }

}