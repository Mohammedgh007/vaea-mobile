
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/dto/home_search_dto.dart';
import 'package:vaea_mobile/data/enums/gender.dart';
import 'package:vaea_mobile/data/model/home_details_model.dart';
import 'package:vaea_mobile/data/repo/home_search_repo.dart';

import '../../data/model/searched_home_listing_model.dart';
import '../../helpers/excpetions/internet_connection_except.dart';
import '../../helpers/excpetions/invalid_screen_access_except.dart';
import '../../helpers/excpetions/unknown_except.dart';

/// It is the BloC component for accessing the house's search parameters in the view.
/// It is used by HomeSearchScreen and HomePromptScreen
class HomeSearchProvider extends ChangeNotifier {

  HomeSearchRepo _repo = HomeSearchRepo();

  // Search
  HomeSearchDto filters = HomeSearchDto(pager: 0, sortingOption: 0);
  List<SearchedHomeListingModel>? searchedListings;

  // home details
  int? targetHomeDetailsId;
  int? sliderImageIndex; // it is used for hero animation
  List<String>? sliderImages; // it is used for hero animation
  HomeDetailsModel? homeDetails;


  /// It searches for the available housing units based on the given filters.
  /// @throws InternetConnectionException, UnknownException
  Future<void> searchHomes() async {
    try {
      searchedListings = await _repo.searchHomes(filters);
      notifyListeners();
    } on InternetConnectionException catch(e) {
      rethrow;
    } on UnknownException catch(e) {
      rethrow;
    }
  }


  /// It searches for the available housing units based on the given filters.
  /// @pre-conditon targetHomeDetailsId has been assigned.
  /// @throws InternetConnectionException, InvalidScreenAccessException
  Future<void> retrieveHomeDetails() async {
    try {
      homeDetails = await _repo.retrieveHomeDetails(targetHomeDetailsId!);
      notifyListeners();
    } on InternetConnectionException catch(e) {
      rethrow;
    } on InvalidScreenAccessException catch(e) {
      rethrow;
    }
  }

}