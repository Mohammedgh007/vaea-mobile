import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vaea_mobile/view/ui_events/closing_search_panel_event.dart';
import 'package:vaea_mobile/view/ui_events/ui_events_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/buttons/filters_sorting_button.dart';
import 'package:vaea_mobile/view/widgets/buttons/segmented_button.dart';
import 'package:vaea_mobile/view/widgets/cards/searched_home_card.dart';
import 'package:vaea_mobile/view/widgets/forms/filter_homes_form.dart';
import 'package:vaea_mobile/view/widgets/forms/sorting_homes_form.dart';
import 'package:vaea_mobile/view/widgets/vaea_ui/vaea_bottom_sheet.dart';
import '../../../data/enums/city_name.dart';
import '../../../data/enums/district_enum.dart';
import '../../../data/enums/home_type.dart';
import '../../../data/model/searched_home_listing_model.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/navigation/bottom_navigation.dart';

/// It handles the ui interaction for HomeSearchScreen
class HomeSearchMobileLayout extends StatefulWidget {
  HomeType defaultHomeType;
  CityName defaultCityName;
  List<SearchedHomeListingModel>? listings;
  bool isLoading; // it is used only when mounting the screen

  Future<void> Function(
      {required HomeType? selectedHomeType,
      required CityName? selectedCityName,
      required DistrictEnum? selectedDistrict,
      required int? bedrooms,
      required int? bathrooms}) handleSubmitFilterForm;
  Future<void> Function(int selectedOption) handleSubmitSortingForm;
  void Function(
      {required int imageIndex,
      required List<String> sliderImages,
      required int homeId}) handleClickListing;

  HomeSearchMobileLayout(
      {super.key,
      required this.defaultHomeType,
      required this.defaultCityName,
      required this.listings,
      required this.isLoading,
      required this.handleSubmitFilterForm,
      required this.handleSubmitSortingForm,
      required this.handleClickListing});

  @override
  State<HomeSearchMobileLayout> createState() => _HomeSearchMobileLayoutState();
}

class _HomeSearchMobileLayoutState extends State<HomeSearchMobileLayout> {
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

    uiEventsManager.listenToClosingSearchPanelEvent((event) {
      _panelController.close();
    });
  }

  /// It is a helper method for build. It initializes the fields of dimensions
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
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      breakpoint = Breakpoint.fromConstraints(constraints);
      layoutConstraints = constraints;
      setupDimensions();

      return Scaffold(
        appBar: AdaptiveTopAppBar(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            previousPageTitle: AppLocalizations.of(context)!.home,
            currPageTitle: AppLocalizations.of(context)!.homeSearch),
        body: VAEABottomSheet(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            title: (isFiltersSelected)
                ? AppLocalizations.of(context)!.filters
                : AppLocalizations.of(context)!.sorting,
            handleClose: () {
              uiEventsManager
                  .fireClosingSearchPanelEvent(ClosingSearchPanelEvent());
              setState(() {
                isPanelOpened = false;
              });
            },
            body: buildBody(),
            slidingPanel: Padding(
              padding: EdgeInsets.only(top: layoutConstraints.maxHeight * 0.12),
              child:
                  (isFiltersSelected) ? buildFilterForm() : buildSortingForm(),
            ),
            panelController: _panelController),
        bottomNavigationBar: (isPanelOpened)
            ? null
            : BottomNavigation(
                currentIndex: 0,
              ),
      );
    });
  }

  /// It builds the body that contains filter sorting button with the list of
  /// housing units or the map and the segmeneted button for switching between
  /// the map view and the list view.
  Widget buildBody() {
    return Column(
      children: [
        SizedBox(height: tabsTopPadding),
        buildTabsSection(),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                  // body
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AnimatedSwitcher(
                    transitionBuilder: (child, animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    duration: const Duration(milliseconds: 300),
                    child: (isShowingMap) ? buildHomesMap() : buildHomesList(),
                  )),
              Positioned(
                // filters and sortings
                bottom: bottomPaddingFilterSortingButton,
                child: buildFilterSortingButton(),
              )
            ],
          ),
        ),
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
            AppLocalizations.of(context)!.listTabText,
            AppLocalizations.of(context)!.mapsTabText
          ],
          optionsValues: const [false, true],
          selectedIndex: (!isShowingMap) ? 0 : 1,
          handleSelect: (bool didClickMap) => setState(() {
                isShowingMap = didClickMap;
              })),
    );
  }

  /// It builds the map view for the markers of homes
  Widget buildHomesMap() {
    return Container(
      width: layoutConstraints.maxWidth,
      height: layoutConstraints.maxHeight,
      padding: EdgeInsets.only(top: tabsTopPadding),
      child: GoogleMap(
          mapType: MapType.normal,
          zoomGesturesEnabled: true,
          zoomControlsEnabled: true,
          markers: (widget.listings == null)
              ? {}
              : widget.listings!
                  .map((e) =>
                      buildMarker(e.listingId, e.lat, e.lon, e.imagesUrls))
                  .toSet(),
          initialCameraPosition:
              CameraPosition(zoom: 11.0, target: LatLng(24.7136, 46.6753))),
    );
  }

  /// It builds a single mark in the map.
  Marker buildMarker(int listingId, double listingLat, double listingLon,
      List<String> imageUrls) {
    return Marker(
        markerId: MarkerId(listingId.toString()),
        position: LatLng(listingLat, listingLon),
        onTap: () {
          // take the user to the details page
          widget.handleClickListing(
              imageIndex: 0, homeId: listingId, sliderImages: imageUrls);
        },
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
  }

  /// It builds the list of retrieved programs
  Widget buildHomesList() {
    if (widget.isLoading || isLoading) {
      return const CircularProgressIndicator.adaptive();
    } else if (widget.listings == null || widget.listings!.isEmpty) {
      return Center(child: Text(AppLocalizations.of(context)!.noResultsFound));
    } else {
      return ListView.separated(
        separatorBuilder: (BuildContext context, int itemIndex) {
          return SizedBox(height: cardsSpacer);
        },
        padding: EdgeInsets.only(top: listTopPadding, bottom: bodyBottomPadding * 4),
        itemCount: widget.listings!.length,
        itemBuilder: (BuildContext context, int itemIndex) {
          return Center(
            child: SearchedHomeCard(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                listingModel: widget.listings![itemIndex],
                handleClickCard: (int imageIndex) {
                  widget.handleClickListing(
                      imageIndex: imageIndex,
                      homeId: widget.listings![itemIndex].listingId,
                      sliderImages: widget.listings![itemIndex].imagesUrls);
                }),
          );
        },
      );
    }
  }

  /// It builds the filter button and the sorting button.
  Widget buildFilterSortingButton() {
    return SizedBox(
      width: layoutConstraints.maxWidth,
      child: Center(
        child: FiltersSortingButton(
            breakpoint: breakpoint,
            layoutConstraints: layoutConstraints,
            handleClickFilters: () {
              setState(() {
                isFiltersSelected = true;
                isPanelOpened = true;
              });
              _panelController.open();
            },
            handleClickSorting: () {
              setState(() {
                isFiltersSelected = false;
                isPanelOpened = true;
              });
              _panelController.open();
            }),
      ),
    );
  }

  /// It is a helper method. It builds the filter form.
  Widget buildFilterForm() {
    return FilterHomesForm(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleSubmitFilterForm: handleSubmitFilterForm,
      defaultHomeType: widget.defaultHomeType,
      defaultCityName: widget.defaultCityName,
    );
  }

  /// It is a helper method. It builds the sorting forms.
  Widget buildSortingForm() {
    return SortingHomeForm(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        handleSubmitSorting: handleSubmitSortingForm);
  }

  /// It handles the event of submitting the filter form by showing loading animation.
  Future<void> handleSubmitFilterForm(
      {required HomeType? selectedHomeType,
      required CityName? selectedCityName,
      required DistrictEnum? selectedDistrict,
      required int? bedrooms,
      required int? bathrooms}) async {
    setState(() {
      isLoading = true;
    });

    widget.handleSubmitFilterForm(
        selectedHomeType: selectedHomeType,
        selectedCityName: selectedCityName,
        selectedDistrict: selectedDistrict,
        bedrooms: bedrooms,
        bathrooms: bathrooms);

    setState(() {
      isLoading = false;
    });
  }

  /// It handles the event of submitting the sorting form by showing loading animation.
  Future<void> handleSubmitSortingForm(int selectedOption) async {
    setState(() {
      isLoading = true;
    });

    widget.handleSubmitSortingForm(selectedOption);

    setState(() {
      isLoading = false;
    });
  }
}
