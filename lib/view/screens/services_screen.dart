import 'dart:io';
import 'package:collection/collection.dart'; // You have to add this manually, for some reason it cannot be added automatically
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vaea_mobile/bloc/providers/booking_provider.dart';
import 'package:vaea_mobile/view/layouts/mobile/services_layout.dart';
import 'package:vaea_mobile/view/widgets/navigation/adaptive_top_app_bar.dart';
import '../../bloc/providers/profile_provider.dart';
import '../../bloc/providers/services_provider.dart';
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

  late final ProfileProvider profileProvider;
  late final BookingProvider bookingProvider;
  late final ServicesProvider servicesProvider;
  bool hasLoadedRequests = false;


  bool isFiltersSelected =
      true; // It determines which form to show when sliding the panel
  bool isPanelOpened = false;
  UiEventsManager uiEventsManager = UiEventsManager();
  bool isLoading =
      false; // it is used when the user modifies the filters or the sorting
  bool isShowingPrev = false;


  @override
  void initState() {
    super.initState();

    servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    bookingProvider = Provider.of<BookingProvider>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (profileProvider.profileModel == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.youNeedSignServices)),
        );
        setState(() { hasLoadedRequests = true; });
      } else {
        await servicesProvider.loadHistory();
        setState(() { hasLoadedRequests = true; });
      }

    });

  }


  @override
  Widget build(BuildContext context) {

    return ServicesLayout(
      hasLoadedRequests: hasLoadedRequests,
      currRequests: servicesProvider.currRequests,
      prevRequests: servicesProvider.prevRequests,
      handleClickAdd: handleClickAddRequest,
    );
  }


  /// It lets the user go to request submission screen.
  void handleClickAddRequest() { Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.submitServiceRequest));
    // check if the user is signed in and has a lease
    if (profileProvider.profileModel != null && bookingProvider.myHomeDetails != null) {
      Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.submitServiceRequest));
    }
  }

}
