
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/booking_provider.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/home_mobile_layout.dart';

import '../../bloc/providers/profile_provider.dart';
import '../../data/model/my_home_details_model.dart';

/// This class handles the view and its interactions with the rest of app
/// for home screen.
class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late BookingProvider bookingProvider;
  late ProfileProvider profileProvider;

  MyHomeDetailsModel? myHomeModel;
  bool isLoading = true;
  bool shouldShowHomeDetails = false;

  @override
  void initState() {
    super.initState();

    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (profileProvider.profileModel == null) {
        setState(() {
          isLoading = false;
          shouldShowHomeDetails = false;
        });
      } else {
        try {
          await bookingProvider.getMyHomeDetails().then((value) {
            setState(() {
              myHomeModel = bookingProvider.myHomeDetails;
              isLoading = false;
              shouldShowHomeDetails = (bookingProvider.myHomeDetails != null);
            });
          });
        } on Exception catch(e) {
          setState(() {
            isLoading = false;
            shouldShowHomeDetails = false;
          });
        }
      }

    });
  }

  @override
  Widget build(BuildContext context) {

    return HomeMobileLayout(
      isScreenLoading: isLoading,
      shouldDisplayHomeDetails: shouldShowHomeDetails,
      homeModel: bookingProvider.myHomeDetails,
      handleClickFindHome: handleClickFindHome,
    );
  }


  /// It handles the button by taking the user to search prompt screen before going
  /// to the search result.
  void handleClickFindHome() {
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.homePrompt));
  }


}

