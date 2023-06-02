
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/booking_provider.dart';
import 'package:vaea_mobile/bloc/providers/profile_provider.dart';
import 'package:vaea_mobile/data/model/home_details_model.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/home_details_mobile_layout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../bloc/providers/home_search_provider.dart';

/// This class handles the view and its interactions with the rest of app
/// for home details screen.
class HomeDetailsScreen extends StatefulWidget {

  @override
  State<HomeDetailsScreen> createState() => _HomeDetailsScreenState();
}

class _HomeDetailsScreenState extends State<HomeDetailsScreen> {

  late HomeSearchProvider searchProvider;
  late BookingProvider bookingProvider;
  late ProfileProvider profileProvider;

  HomeDetailsModel? detailsModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    searchProvider = Provider.of<HomeSearchProvider>(context, listen: false);
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);

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
    if (profileProvider.profileModel == null && profileProvider.targetScreenAfterSignIn == null) {
      profileProvider.targetScreenAfterSignIn = ScreenName.homeDetails;
    }

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
    // check if the user is signed in before progressing to the booking screen
    if (profileProvider.profileModel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(AppLocalizations.of(context)!.youNeedToSignUpBeforeBook),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.signUp)),
                  child: Text(AppLocalizations.of(context)!.signUp, style: TextStyle(color: Colors.lightBlueAccent))
                )
              ],
            ),
          ),
        ),
      );
      return;
    }

    // get a lock for the unit before booking it.
    setState(() => isLoading = true);
    if (await bookingProvider.lockUnit(searchProvider.homeDetails!.listingId)) {
      bookingProvider.listingDetailsModel = searchProvider.homeDetails;
      Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.booking));

      setState(() => isLoading = false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.bookAnotherUnit)),
      );
      setState(() => isLoading = false);
      Navigator.of(context).pop();
    }
  }


}