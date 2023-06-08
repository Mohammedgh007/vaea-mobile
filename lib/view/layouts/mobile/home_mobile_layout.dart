
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:vaea_mobile/data/model/curr_home_purview_model.dart';
import 'package:vaea_mobile/data/model/my_home_details_model.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';
import 'package:vaea_mobile/view/widgets/cards/my_home_card.dart';
import 'package:vaea_mobile/view/widgets/cards/my_roommates_card.dart';

import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/navigation/bottom_navigation.dart';

/// It handles the ui appearance and user interaction for HomeScreen.
class HomeMobileLayout extends StatefulWidget {

  // null value indicates that the user has not rent yet
  bool isScreenLoading;
  bool shouldDisplayHomeDetails;
  MyHomeDetailsModel? homeModel;
  void Function() handleClickFindHome;


  HomeMobileLayout({
    super.key,
    required this.isScreenLoading,
    required this.shouldDisplayHomeDetails,
    required this.homeModel,
    required this.handleClickFindHome
  });

  @override
  State<HomeMobileLayout> createState() => _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends State<HomeMobileLayout> {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  // dimensions
  late double imageWidth;
  late double imageTopMargin;
  late double textVerticalMargin;


  /// It is a helper method to build(). It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      imageWidth = layoutConstraints.maxWidth * 0.60;
      imageTopMargin = layoutConstraints.maxHeight * 0.02;
      textVerticalMargin = layoutConstraints.maxHeight * 0.05;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageWidth = layoutConstraints.maxWidth * 0.75;
      imageTopMargin = layoutConstraints.maxHeight * 0.02;
      textVerticalMargin = layoutConstraints.maxHeight * 0.035;
    } else {
      imageWidth = layoutConstraints.maxWidth * 0.75;
      imageTopMargin = layoutConstraints.maxHeight * 0.02;
      textVerticalMargin = layoutConstraints.maxHeight * 0.035;
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
              currPageTitle: AppLocalizations.of(context)!.home,
              breakpoint: breakpoint,
              layoutConstraints: constraints,
            ),
            body: (widget.homeModel == null)
              ? buildNonRentBody()
              : buildRentBody(),
            floatingActionButton: (widget.homeModel == null)
              ? null
              : PrimaryBtn(
                breakpoint: breakpoint,
                layoutConstraints: layoutConstraints,
                handleClick: widget.handleClickFindHome,
                buttonText: AppLocalizations.of(context)!.exploreHomes
            ),
            bottomNavigationBar: BottomNavigation(currentIndex: 0),
          ),
        );
      },
    );
  }


  /// It builds the body if the user has not rent yet.
  Widget buildNonRentBody() {
    return Center(
      child: (widget.isScreenLoading) ? const CircularProgressIndicator.adaptive() : Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: imageTopMargin),
          buildIllustrationSection(),
          SizedBox(height: textVerticalMargin),
          buildTextSection(),
          SizedBox(height: textVerticalMargin),
          buildActionBtnSection(),
          SizedBox(height: textVerticalMargin)
        ],
      ),
    );
  }


  /// It is a helper method to buildNonRentBody. It builds the image section.
  Widget buildIllustrationSection() {
    return SvgPicture.asset(
      "assets/logos/home_screen_illustration.svg",
      width: imageWidth,
      fit: BoxFit.fitWidth,
      alignment: Alignment.center,
    );
  }


  /// It is a helper method for buildNonRentBody. It builds the text "let us .." section.
  Widget buildTextSection() {
    return Text(
      AppLocalizations.of(context)!.yourJourneyStartHere,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
        fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight
      ),
    );
  }


  /// It is a helper method for buildNonRentBody. It builds the find my home button.
  Widget buildActionBtnSection() {
    return PrimaryBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: widget.handleClickFindHome,
      buttonText: AppLocalizations.of(context)!.findMyHome
    );
  }


  /// It builds the body if the user has rent already.
  Widget buildRentBody() {
    EdgeInsets viewPadding = MediaQuery.of(context).viewPadding;
    return Container(
      width: layoutConstraints.maxWidth,
      padding: EdgeInsets.only(top: imageTopMargin),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: imageTopMargin),
            MyHomeCard(
              breakpoint: breakpoint,
              layoutConstraints: layoutConstraints,
              homeDetails: widget.homeModel!
            ),
            if (widget.homeModel!.roommates != null && widget.homeModel!.roommates!.isNotEmpty) SizedBox(height: textVerticalMargin),
            if (widget.homeModel!.roommates != null && widget.homeModel!.roommates!.isNotEmpty) MyRoommatesCards(
              breakpoint: breakpoint,
              layoutConstraints: layoutConstraints,
              homeDetails: widget.homeModel!
            ),
            SizedBox(height: imageTopMargin * 7),

          ],
        ),
      ),
    );
  }

}


