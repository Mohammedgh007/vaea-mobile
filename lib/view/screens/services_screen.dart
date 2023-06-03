import 'dart:io';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vaea_mobile/view/widgets/navigation/adaptive_top_app_bar.dart';
import '../../bloc/providers/services_provider.dart';
import '../../data/enums/services_enums.dart';
import '../../routes_mapper.dart';
import '../style/colors.dart';
import '../ui_events/ui_events_manager.dart';
import '../widgets/buttons/segmented_button.dart';
import '../widgets/navigation/bottom_navigation.dart';

/// This class handles the view and its interactions with the rest of app
/// for services screen.
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  final PanelController _panelController = PanelController();
  bool isFiltersSelected =
      true; // It determines which form to show when sliding the panel
  bool isPanelOpened = false;
  UiEventsManager uiEventsManager = UiEventsManager();
  bool isLoading =
      false; // it is used when the user modifies the filters or the sorting
  bool isShowingMap = false;

  // dimensions
  late double bottomPaddingFilterSortingButton;
  late double tabsTopPadding;
  late double listTopPadding;
  late double bodyBottomPadding;
  late double cardsSpacer;

  @override
  void initState() {
    super.initState();
    Provider.of<ServicesProvider>(context, listen: false).loadServicesHistory();
    uiEventsManager.listenToClosingSearchPanelEvent((event) {
      _panelController.close();
    });
  }

  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      bottomPaddingFilterSortingButton = layoutConstraints.maxHeight * 0.30;
      tabsTopPadding = layoutConstraints.maxHeight * 0.02;
      listTopPadding = layoutConstraints.maxHeight * 0.03;
      bodyBottomPadding = MediaQuery.of(context).viewPadding.bottom +
          kBottomNavigationBarHeight;
      cardsSpacer = layoutConstraints.maxHeight * 0.04;
    } else if (breakpoint.device.name == "mediumHandset") {
      bottomPaddingFilterSortingButton = layoutConstraints.maxHeight * 0.30;
      tabsTopPadding = layoutConstraints.maxHeight * 0.02;
      listTopPadding = layoutConstraints.maxHeight * 0.03;
      bodyBottomPadding = MediaQuery.of(context).viewPadding.bottom +
          kBottomNavigationBarHeight;
      cardsSpacer = layoutConstraints.maxHeight * 0.04;
    } else {
      bottomPaddingFilterSortingButton = layoutConstraints.maxHeight * 0.30;
      tabsTopPadding = layoutConstraints.maxHeight * 0.02;
      listTopPadding = layoutConstraints.maxHeight * 0.03;
      bodyBottomPadding = MediaQuery.of(context).viewPadding.bottom +
          kBottomNavigationBarHeight;
      cardsSpacer = layoutConstraints.maxHeight * 0.04;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
        builder: (context, provider, child) => LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              breakpoint = Breakpoint.fromConstraints(constraints);
              layoutConstraints = constraints;
              setupDimensions();
              return Scaffold(
                floatingActionButton: (Platform.isAndroid)
                    ? FloatingActionButton(
                        backgroundColor: AppColors.lightPrimary,
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              RoutesMapper.getScreenRoute(
                                  ScreenName.serviceList));
                        },
                        child: const Icon(
                          Icons.add,
                          size: 40,
                        ),
                      )
                    : null,
                appBar: AdaptiveTopAppBar(
                  breakpoint: breakpoint,
                  layoutConstraints: constraints,
                  currPageTitle: AppLocalizations.of(context)!.services,
                  trailingWidgets: (Platform.isIOS)
                      ? const [Center(child: Text('Add Request'))]
                      : null,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Center(child: buildTabsSection()),
                    if (provider.serviceResponse != null)
                      Expanded(
                          child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 100.h),
                        itemBuilder: (context, index) => RequestElement(
                            requestElement:
                                provider.serviceResponse!.data[index]),
                        itemCount: provider.serviceResponse!.data.length,
                      )),
                  ],
                ),
                bottomNavigationBar: BottomNavigation(currentIndex: 2),
              );
            }));
  }

  Widget buildTabsSection() {
    return VAEASegmentedButton<bool>(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      options: [
        AppLocalizations.of(context)!.current,
        AppLocalizations.of(context)!.previous
      ],
      optionsValues: const [false, true],
      selectedIndex: (!isShowingMap) ? 0 : 1,
      handleSelect: (bool didClickMap) => setState(() {
        isShowingMap = didClickMap;
      }),
    );
  }
}

class RequestElement extends StatelessWidget {
  final ServiceRequest requestElement;
  const RequestElement({super.key, required this.requestElement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,

              // border: Border.all(color: AppColors.lightSecondary),
              borderRadius: BorderRadius.circular(18)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
                child: Image.asset(
                  ServicesTypes.values
                      .firstWhere((element) =>
                          element.title.toLowerCase() ==
                          requestElement.requestType.toLowerCase())
                      .image,
                  height: 114.h,
                  width: 110.w,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 15.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    requestElement.requestType,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w700, fontFamily: 'Montserrat'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.h),
                    child: Container(
                        width: 183.w,
                        // height: 24.h,
                        decoration: BoxDecoration(
                            color: AppColors.lightPrimary,

                            // border: Border.all(color: AppColors.lightSecondary),
                            borderRadius: BorderRadius.circular(18)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 14.h,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/alarm_pending.png',
                                  width: 26.h,
                                  height: 26.h,
                                  // color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              Text(
                                requestElement.status,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Montserrat'),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Text(
                    'Order on ${getDateFormatted(requestElement.orderDate)}',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: AppColors.mediumEmphasisText,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Montserrat'),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  getDateFormatted(String date) {
    DateTime parsedDate = DateTime.parse(date); // Parse it to DateTime

    final DateFormat formatter = DateFormat('h:mm a dd/MM');
    final String formatted = formatter.format(parsedDate);
    return formatted;
  }
}
