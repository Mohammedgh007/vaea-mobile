import 'package:breakpoint/breakpoint.dart';
import 'package:coast/coast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/widgets/buttons/white_primary_button.dart';
import 'package:vaea_mobile/view/widgets/containers/intro_page_container.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// It structures the view layout for the IntroScreen
class IntroMobileLayout extends StatefulWidget {
  void Function() handleClickGetStarted;
  void Function() handleClickSignIn;

  IntroMobileLayout(
      {super.key,
      required this.handleClickGetStarted,
      required this.handleClickSignIn});

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
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            child: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.primary,
              body: Coast(
                physics: const ClampingScrollPhysics(),
                controller: coastController,
                beaches: [
                  buildFirstBeach(constraints),
                  buildSecondBeach(constraints),
                  buildThirdBeach(constraints)
                ],
                observers: [
                  CrabController(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// It builds the first page.
  Beach buildFirstBeach(BoxConstraints constraints) {
    return Beach(builder: (ctx) {
      return buildPage(
          localImagePath: "assets/images/slider_flexible_housing.png",
          title: AppLocalizations.of(ctx)!.flexibleHousing,
          text: AppLocalizations.of(ctx)!.flexibleHousingBody,
          index: 0,
          constraints: constraints,
          actionBtns: buildActionBtns(ctx, constraints, false));
    });
  }

  /// It builds the second page.
  Beach buildSecondBeach(BoxConstraints constraints) {
    return Beach(builder: (ctx) {
      return buildPage(
          localImagePath: "assets/images/slider_active.png",
          title: AppLocalizations.of(ctx)!.activeCommunity,
          text: AppLocalizations.of(ctx)!.activeCommunityBody,
          index: 1,
          constraints: constraints,
          actionBtns: buildActionBtns(ctx, constraints, false));
    });
  }

  /// It builds the third page.
  Beach buildThirdBeach(BoxConstraints constraints) {
    return Beach(builder: (ctx) {
      return buildPage(
          localImagePath: "assets/images/slider_services.png",
          title: AppLocalizations.of(ctx)!.maintenanceServices,
          text: AppLocalizations.of(ctx)!.maintenanceServicesBody,
          index: 2,
          constraints: constraints,
          actionBtns: buildActionBtns(ctx, constraints, true));
    });
  }

  void nextPage() {
    coastController.animateTo(
      beach: coastController.beach!.toInt() + 1,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  /// It is a helper method for buildThirdBeach. It builds the action buttons that
  /// includes sign up and sign in
  Widget buildActionBtns(
      BuildContext ctx, BoxConstraints constraints, bool getStarted) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WhitePrimaryBtn(
          breakpoint: breakpoint,
          layoutConstraints: constraints,
          handleClick: getStarted ? widget.handleClickGetStarted : nextPage,
          buttonText: getStarted
              ? AppLocalizations.of(context)!.getStarted
              : AppLocalizations.of(context)!.next,
          fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
        ),
        SizedBox(height: constraints.maxHeight * 0.02),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.youHaveAccountAlready,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  color: Theme.of(context).colorScheme.onPrimary),
            ),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: widget.handleClickSignIn,
              child: Text(
                AppLocalizations.of(context)!.signIn,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimary,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
        SizedBox(height: constraints.maxHeight * 0.02),
      ],
    );
  }

  /// It builds a single child of PageView.
  Widget buildPage(
      {required String localImagePath,
      required String title,
      required String text,
      required int index,
      required BoxConstraints constraints,
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
