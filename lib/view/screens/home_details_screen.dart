
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/data/model/home_details_model.dart';
import 'package:vaea_mobile/view/layouts/mobile/home_details_mobile_layout.dart';

import '../../bloc/providers/home_search_provider.dart';

/// This class handles the view and its interactions with the rest of app
/// for home details screen.
class HomeDetailsScreen extends StatefulWidget {

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {

  late HomeSearchProvider searchProvider;

  HomeDetailsModel? detailsModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    searchProvider = Provider.of<HomeSearchProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      searchProvider.retrieveHomeDetails().then((value) {
        setState(() {
          detailsModel = searchProvider.homeDetails;
          isLoading = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return HomeDetailsMobileLayout(
      isLoading: isLoading,
      detailsModel: detailsModel,
      listingId: searchProvider.targetHomeDetailsId!,
      sliderImageIndex: searchProvider.sliderImageIndex!,
      sliderImages: searchProvider.sliderImages!,
      handleClickBook: handleClickBook
    );
  }


  /// It handles the event of clicking book.
  Future<void> handleClickBook() async {

  }


}