
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/home_search_provider.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/home_search_mobile_layout.dart';

import '../../data/enums/city_name.dart';
import '../../data/enums/district_enum.dart';
import '../../data/enums/home_type.dart';
import '../../data/model/searched_home_listing_model.dart';

/// This class handles the view and its interactions with the rest of app
/// for home search screen.
class HomeSearchScreen extends StatefulWidget {

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {

  late HomeSearchProvider searchProvider;

  List<SearchedHomeListingModel>? listings;
  bool isLoading = true;


  @override
  void initState() {
    super.initState();

    searchProvider = Provider.of<HomeSearchProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchProvider.searchHomes().then((value) {
        setState(() {
          listings = searchProvider.searchedListings;
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return HomeSearchMobileLayout(
      defaultHomeType: searchProvider.filters.homeType!,
      defaultCityName: searchProvider.filters.cityName!,
      listings: listings,
      isLoading: isLoading,
      handleSubmitFilterForm: handleSubmitFilterForm,
      handleSubmitSortingForm: handleSubmitSortingForm,
      handleClickListing: handleClickList,
    );
  }


  /// It researches based on the given filters
  Future<void> handleSubmitFilterForm({
    required HomeType? selectedHomeType,
    required CityName? selectedCityName,
    required DistrictEnum? selectedDistrict,
    required int? bedrooms,
    required int? bathrooms
  }) async {

    searchProvider.filters.homeType = selectedHomeType;
    searchProvider.filters.cityName = selectedCityName;
    searchProvider.filters.district = selectedDistrict;
    searchProvider.filters.bedrooms = bedrooms;
    searchProvider.filters.bathrooms = bathrooms;
    await searchProvider.searchHomes();
    setState(() {
      listings = searchProvider.searchedListings;
    });
  }


  /// It researches to match the given sorting.
  Future<void> handleSubmitSortingForm(int selectedOption) async {
    searchProvider.filters.sortingOption = selectedOption;
    await searchProvider.searchHomes();
    setState(() {
      listings = searchProvider.searchedListings;
    });
  }


  /// It handles the event of clicking a listing by taking the user to the home details.
  void handleClickList({required int imageIndex, required List<String> sliderImages, required int homeId}) {
    searchProvider.targetHomeDetailsId = homeId;
    searchProvider.sliderImageIndex = imageIndex;
    searchProvider.sliderImages = sliderImages;
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => RoutesMapper.getScreenWidget(ScreenName.homeDetails)));
  }


}