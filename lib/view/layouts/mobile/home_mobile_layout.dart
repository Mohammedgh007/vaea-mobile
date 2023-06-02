
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:vaea_mobile/data/model/curr_home_purview_model.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';

import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/navigation/bottom_navigation.dart';

/// It handles the ui appearance and user interaction for HomeScreen.
class HomeMobileLayout extends StatefulWidget {

  // null value indicates that the user has not rent yet
  CurrHomePurviewModel? homeModel;
  void Function() handleClickFindHome;

  HomeMobileLayout({
    super.key,
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
  late double imageHeight;
  late double imageTopMargin;
  late double textVerticalMargin;


  /// It is a helper method to build(). It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      imageWidth = layoutConstraints.maxWidth * 0.92;
      imageHeight = layoutConstraints.maxHeight * 0.42;
      imageTopMargin = layoutConstraints.maxHeight * 0.02;
      textVerticalMargin = layoutConstraints.maxHeight * 0.04;
    } else if (breakpoint.device.name == "mediumHandset") {
      imageWidth = layoutConstraints.maxWidth * 0.92;
      imageHeight = layoutConstraints.maxHeight * 0.46;
      imageTopMargin = layoutConstraints.maxHeight * 0.02;
      textVerticalMargin = layoutConstraints.maxHeight * 0.02;
    } else {
      imageWidth = layoutConstraints.maxWidth * 0.92;
      imageHeight = layoutConstraints.maxHeight * 0.46;
      imageTopMargin = layoutConstraints.maxHeight * 0.02;
      textVerticalMargin = layoutConstraints.maxHeight * 0.02;
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
            bottomNavigationBar: BottomNavigation(currentIndex: 0),
          ),
        );
      },
    );
  }


  /// It builds the body if the user has not rent yet.
  Widget buildNonRentBody() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: imageTopMargin),
          buildImageSection(),
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
  Widget buildImageSection() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(imageWidth * 0.04),
        child: Image.asset(
          "assets/images/before_booking_home.png",
          width: imageWidth,
          //height: imageHeight,
          fit: BoxFit.fill,
          alignment: Alignment.center,
        ),
      ),
    );
  }


  /// It is a helper method for buildNonRentBody. It builds the text "let us .." section.
  Widget buildTextSection() {
    return Text(
      AppLocalizations.of(context)!.letUsWelcomeYouHome,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
        fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight
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
    return Column();
  }

}


