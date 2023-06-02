
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

/// It builds the filters and sorting button based on VAEA theme.
class FiltersSortingButton extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  void Function() handleClickFilters;
  void Function() handleClickSorting;

  // dimensions
  late double buttonWidth;
  late double buttonsSpacerWidth;
  late double buttonPadding;
  late double iconSize;

  FiltersSortingButton({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleClickFilters,
    required this.handleClickSorting
  }) {
    setupDimensions();
  }


  /// It is a helper method for the constructor. It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      buttonWidth = layoutConstraints.maxWidth * 0.51;
      buttonsSpacerWidth = layoutConstraints.maxHeight * 0.002;
      buttonPadding = layoutConstraints.minWidth * 0.02;
      iconSize = layoutConstraints.maxWidth * 0.0367;
    } else if (breakpoint.device.name == "mediumHandset") {
      buttonWidth = layoutConstraints.maxWidth * 0.51;
      buttonsSpacerWidth = layoutConstraints.maxHeight * 0.002;
      buttonPadding = layoutConstraints.minWidth * 0.02;
      iconSize = layoutConstraints.maxWidth * 0.0367;
    } else {
      buttonWidth = layoutConstraints.maxWidth * 0.51;
      buttonsSpacerWidth = layoutConstraints.maxHeight * 0.002;
      buttonPadding = layoutConstraints.minWidth * 0.02;
      iconSize = layoutConstraints.maxWidth * 0.0367;
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: buttonWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(buttonWidth * 0.1)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildFiltersSection(context),
          Container(
            height: (buttonPadding * 2) + iconSize,
            width: buttonsSpacerWidth,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          buildSortingSection(context),
        ],
      ),
    );
  }


  /// It is a helper method. It builds the row the contains the filter section.
  Widget buildFiltersSection(BuildContext context) {
    return GestureDetector(
      onTap: handleClickFilters,
      child: Container(
        width: buttonWidth / 2 - buttonsSpacerWidth,
        padding: EdgeInsets.all(buttonPadding),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.filters,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  fontWeight: Theme.of(context).textTheme.labelSmall!.fontWeight,
                  color: Theme.of(context).colorScheme.onPrimary
                ),
              ),
              Icon(
                Icons.filter_alt_rounded,
                size: iconSize,
                color: Theme.of(context).colorScheme.onPrimary
              )
            ],
          ),
        ),
      ),
    );
  }


  /// It is a helper method. It builds the row the contains the sorting section.
  Widget buildSortingSection(BuildContext context) {
    return GestureDetector(
      onTap: handleClickSorting,
      child: Container(
        width: buttonWidth / 2 - buttonsSpacerWidth,
        padding: EdgeInsets.all(buttonPadding),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.sorting,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
                  fontWeight: Theme.of(context).textTheme.labelSmall!.fontWeight,
                  color: Theme.of(context).colorScheme.onPrimary
                ),
              ),
              Icon(
                Icons.sort_rounded,
                size: iconSize,
                color: Theme.of(context).colorScheme.onPrimary
              )
            ],
          ),
        ),
      ),
    );
  }

}