import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';
import 'package:vaea_mobile/view/widgets/containers/intro_page_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// It structures the view layout for the IntroScreen
class IntroMobileLayout extends StatefulWidget {

  void Function() handleClickGetStarted;

  IntroMobileLayout({
    super.key,
    required this.handleClickGetStarted
  });

  @override
  State<IntroMobileLayout> createState() => _IntroMobileLayoutState();
}

class _IntroMobileLayoutState extends State<IntroMobileLayout> {

  late Breakpoint breakpoint;
  final coastController = CoastController();

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        breakpoint = Breakpoint.fromConstraints(constraints);

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            body: Coast(
              controller: coastController,
              beaches: [
                buildFirstBeach(constraints),
                buildSecondBeach(constraints),
                buildThirdBeach(constraints)
              ],
              observers: [
                CrabController(),
              ],
            )
          ),
        );
      },
    );
  }


  /// It builds the first page.
  Beach buildFirstBeach(BoxConstraints constraints) {
    return Beach(builder: (ctx) {
      return buildPage(
        localImagePath: "assets/images/background_flexible_housing.png",
        title: AppLocalizations.of(ctx)!.flexibleHousing,
        text: AppLocalizations.of(ctx)!.flexibleHousingBody,
        index: 0,
        constraints: constraints
      );
    });
  }


  /// It builds the second page.
  Beach buildSecondBeach(BoxConstraints constraints) {
    return Beach(builder: (ctx) {
      return buildPage(
          localImagePath: "assets/images/background_active.png",
          title: AppLocalizations.of(ctx)!.activeCommunity,
          text: AppLocalizations.of(ctx)!.activeCommunityBody,
          index: 1,
          constraints: constraints
      );
    });
  }


  /// It builds the third page.
  Beach buildThirdBeach(BoxConstraints constraints) {
    return Beach(builder: (ctx) {
      return buildPage(
        localImagePath: "assets/images/background_services.png",
        title: AppLocalizations.of(ctx)!.maintenanceServices,
        text: AppLocalizations.of(ctx)!.maintenanceServicesBody,
        index: 2,
        constraints: constraints,
        actionBtns: buildActionBtns(ctx, constraints)
      );
    });
  }


  /// It is a helper method for buildThirdBeach. It builds the action buttons that
  /// includes sign up and sign in
  Widget buildActionBtns(BuildContext ctx, BoxConstraints constraints) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PrimaryBtn(
          breakpoint: breakpoint,
          layoutConstraints: constraints,
          handleClick: widget.handleClickGetStarted,
          buttonText: AppLocalizations.of(context)!.getStarted
        ),
        SizedBox(height: constraints.maxHeight * 0.015),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.youHaveAccountAlready,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                  color: Theme.of(context).colorScheme.onBackground
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
                onTap: () => Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.signIn)),
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall!.fontSize,
                    color: Theme.of(context).colorScheme.primary,
                    decoration: TextDecoration.underline,
                  ),
                )
            )
          ],
        )
      ],
    );
  }


  /// It builds a single child of PageView.
  Widget buildPage({required String localImagePath, required String title,
    required String text, required int index, required BoxConstraints constraints,
    Widget? actionBtns}) {
    return IntroPageContainer(
      breakpoint: breakpoint,
      layoutBoxConstrains: constraints,
      pageIndex: index,
      localImagePath: localImagePath,
      titleStr: title,
      bodyStr: text,
      actionsBtns: actionBtns,
    );
  }


}