import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaea_mobile/view/widgets/cards/service_request_overview_card.dart';

import '../../../data/model/request_overview_model.dart';
import '../../widgets/buttons/segmented_button.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/navigation/bottom_navigation.dart';

/// It handles the ui appearance and user interaction for ServicesScreen.
class ServicesLayout extends StatefulWidget {

  bool hasLoadedRequests;
  List<ServiceRequestOverviewModel> prevRequests;
  List<ServiceRequestOverviewModel> currRequests;
  void Function() handleClickAdd;

  ServicesLayout({
    super.key,
    required this.hasLoadedRequests,
    required this.prevRequests,
    required this.currRequests,
    required this.handleClickAdd,
  });

  @override
  State<ServicesLayout> createState() => _ServicesLayoutState();
}

class _ServicesLayoutState extends State<ServicesLayout> {

  bool isShowingCurr = true;

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  // dimensions
  late double tabsTopPadding;
  late double listTopPadding;
  late double bodyBottomPadding;
  late double cardsSpacer;

  /// It is a helper method for build. It initializes the fields of dimensions
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      tabsTopPadding = layoutConstraints.maxHeight * 0.02;
      listTopPadding = layoutConstraints.maxHeight * 0.03;
      bodyBottomPadding = MediaQuery.of(context).viewPadding.bottom +
          kBottomNavigationBarHeight;
      cardsSpacer = layoutConstraints.maxHeight * 0.04;
    } else if (breakpoint.device.name == "mediumHandset") {
      tabsTopPadding = layoutConstraints.maxHeight * 0.02;
      listTopPadding = layoutConstraints.maxHeight * 0.03;
      bodyBottomPadding = MediaQuery.of(context).viewPadding.bottom +
          kBottomNavigationBarHeight;
      cardsSpacer = layoutConstraints.maxHeight * 0.04;
    } else {
      tabsTopPadding = layoutConstraints.maxHeight * 0.02;
      listTopPadding = layoutConstraints.maxHeight * 0.03;
      bodyBottomPadding = MediaQuery.of(context).viewPadding.bottom +
          kBottomNavigationBarHeight;
      cardsSpacer = layoutConstraints.maxHeight * 0.04;
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
          onWillPop: () async => false,
          child: Scaffold(
            appBar: AdaptiveTopAppBar(
              currPageTitle: AppLocalizations.of(context)!.services,
              breakpoint: breakpoint,
              layoutConstraints: constraints,
              trailingWidgets: [
                if (GetPlatform.isIOS) TextButton(onPressed: widget.handleClickAdd, child: Text(AppLocalizations.of(context)!.addRequest))
              ],
            ),
            body: (widget.hasLoadedRequests) ? buildBody() : const CircularProgressIndicator.adaptive(),
            bottomNavigationBar: BottomNavigation(currentIndex: 2),
            floatingActionButton: (GetPlatform.isIOS) ? null : FloatingActionButton.extended(
              onPressed: widget.handleClickAdd,
              label: Text(AppLocalizations.of(context)!.addRequest),
              icon: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }


  /// It is a helper method for build(). It builds the body.
  Widget buildBody() {
    return Column(
      children: [
        SizedBox(height: tabsTopPadding),
        buildTabsSection(),
        Expanded(
          child: AnimatedSwitcher(
            transitionBuilder: (child, animation) {
              return SlideTransition(position: Tween<Offset>(
                begin: Offset(1.0, 0.0),
                end: Offset(0.0, 0.0),
              ).animate(animation), child: child);
            },
            duration: const Duration(milliseconds: 300),
            child: (isShowingCurr)
              ? buildSelectedRequestsList(widget.currRequests, "curr reqs")
              : buildSelectedRequestsList(widget.prevRequests, "prev reqs") ,
          ),
        )
      ],
    );
  }


  /// It is a helper method for buildBody. It builds the tabs at the top of the page.
  Widget buildTabsSection() {
    return Container(
      width: layoutConstraints.maxWidth,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: VAEASegmentedButton<bool>(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        options: [
          AppLocalizations.of(context)!.current,
          AppLocalizations.of(context)!.previous
        ],
        optionsValues: const [false, true],
        selectedIndex: (isShowingCurr) ? 0 : 1,
        handleSelect: (bool didClickPrev) => setState(() {
          isShowingCurr = !didClickPrev;
        })),
    );
  }


  Widget buildSelectedRequestsList(List<ServiceRequestOverviewModel> selectedRequests, String key) {
    if ( selectedRequests.isEmpty ) {
      return Center(key: ValueKey(key), child: Text(AppLocalizations.of(context)!.noResultsFound));
    } else {
      return ListView.separated(
        key: ValueKey(key),
        separatorBuilder: (BuildContext context, int itemIndex) => SizedBox(height: cardsSpacer),
        padding: EdgeInsets.only(top: listTopPadding, bottom: bodyBottomPadding * 2),
        itemCount: selectedRequests.length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return Center(
            child: ServiceRequestOverviewCard(
              breakpoint: breakpoint,
              layoutConstraints: layoutConstraints,
              requestModel: selectedRequests[itemIndex]
            ),
          );
        }
      );
    }
  }

}
