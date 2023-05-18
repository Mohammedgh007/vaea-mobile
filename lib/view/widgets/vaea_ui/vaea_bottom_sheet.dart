
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/ui_events/closing_search_panel_event.dart';
import 'package:vaea_mobile/view/ui_events/ui_events_manager.dart';

/// It is a bottom sheet/sliding panel that is used to show the info asa pop up
/// window for the mobile only. It handles showing and hiding the panel using
/// the given controller
class VAEABottomSheet extends StatelessWidget {


  final Breakpoint breakpoint;
  final BoxConstraints layoutConstraints;

  final String title;
  final void Function() handleClose;
  /// body is the body of scaffold that is displayed when the panel is hidden
  final Widget body;
  /// It includes all the view below the panel header
  final Widget slidingPanel;
  final PanelController panelController;

  // dimensions
  late double horizontalPadding;
  late double slidingIconTopPadding;
  late double slidingIconWidth;
  late double closeIconSize;
  late double headerBottomPadding;
  late double closeIconTitleTopMargin;
  late double maxPanelHeight;
  late double borderRadius;

  VAEABottomSheet({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.title,
    required this.handleClose,
    required this.body,
    required this.slidingPanel,
    required this.panelController
  }) {
    setupDimensions();
  }

  /// It is a helper method for constructor. It initializes the dimensions fields
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      horizontalPadding = layoutConstraints.maxWidth * 0.04;
      slidingIconTopPadding = layoutConstraints.maxHeight * 0.015;
      slidingIconWidth = layoutConstraints.maxWidth * 0.16;
      closeIconSize = layoutConstraints.maxWidth * 0.098;
      headerBottomPadding = layoutConstraints.maxHeight * 0.004;
      closeIconTitleTopMargin = layoutConstraints.maxHeight * 0.01;
      maxPanelHeight = layoutConstraints.maxHeight * 0.85;
      borderRadius = layoutConstraints.maxWidth * 0.15;
    } else if (breakpoint.device.name == "mediumHandset") {
      horizontalPadding = layoutConstraints.maxWidth * 0.04;
      slidingIconTopPadding = layoutConstraints.maxHeight * 0.015;
      slidingIconWidth = layoutConstraints.maxWidth * 0.17;
      closeIconSize = layoutConstraints.maxWidth * 0.098;
      headerBottomPadding = layoutConstraints.maxHeight * 0.004;
      closeIconTitleTopMargin = layoutConstraints.maxHeight * 0.01;
      maxPanelHeight = layoutConstraints.maxHeight * 0.85;
      borderRadius = layoutConstraints.maxWidth * 0.15;
    } else {
      horizontalPadding = layoutConstraints.maxWidth * 0.04;
      slidingIconTopPadding = layoutConstraints.maxHeight * 0.015;
      slidingIconWidth = layoutConstraints.maxWidth * 0.17;
      closeIconSize = layoutConstraints.maxWidth * 0.098;
      headerBottomPadding = layoutConstraints.maxHeight * 0.004;
      closeIconTitleTopMargin = layoutConstraints.maxHeight * 0.01;
      maxPanelHeight = layoutConstraints.maxHeight * 0.85;
      borderRadius = layoutConstraints.maxWidth * 0.15;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      header: buildPanelHeader(context),
      body: body,
      panel: Container(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        height: layoutConstraints.maxHeight * 0.95,
        child: slidingPanel,
      ),
      controller: panelController,
      onPanelClosed: handleClose,
      minHeight: 0,
      maxHeight: maxPanelHeight,
      backdropColor: Colors.black54,
      onPanelSlide: (double position) {
        if (position == 0 && panelController.isPanelOpen) {
          panelController.hide();
        }
      },
      isDraggable: true,
      defaultPanelState: PanelState.CLOSED,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(borderRadius),
        topLeft: Radius.circular(borderRadius)
      ),
    );
  }


  /// It builds the header section of the panel.
  Widget buildPanelHeader(BuildContext context) {
    return Container(
      width: layoutConstraints.maxWidth,
      padding: EdgeInsets.only( bottom: headerBottomPadding, right: horizontalPadding, left: horizontalPadding ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(240, 240, 240, 1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(borderRadius),
          topLeft: Radius.circular(borderRadius)
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: slidingIconTopPadding),
          buildSlidingIconRow(context),
          SizedBox(height: closeIconTitleTopMargin),
          buildTitleExitBtnRow(context),
          SizedBox(height: headerBottomPadding),
        ],
      ),
    );
  }


  /// It is a helper method for buildPanelHeader. It builds the title text section.
  Widget buildTitleExitBtnRow(BuildContext context) {
    return SizedBox(
      width: layoutConstraints.maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
              fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.outline,
              size: closeIconSize
            ),
            onPressed: () {
              panelController.close();
            },
          )
        ],
      ),
    );
  }


  /// It is a helper method for buildPanelHeader. It builds the sliding icon in the middle.
  Widget buildSlidingIconRow(BuildContext context) {
    return Container(
      height: slidingIconWidth * 0.09,
      width: slidingIconWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Theme.of(context).colorScheme.outline
      ),
    );
  }


  /// It is a helper method for buildPanelHeader. It builds the close button.
  Widget buildCloseBtn(BuildContext context, bool isRTL) {

    return Positioned(
      top: closeIconTitleTopMargin,
      left: (!isRTL) ? null : horizontalPadding,
      right: (!isRTL) ? horizontalPadding : null,
      child: IconButton(
        icon: Icon(
          Icons.close,
          color: Theme.of(context).colorScheme.outline,
          size: closeIconSize
        ),
        onPressed: () {
          panelController.close();
        },
      ),
    );
  }
}