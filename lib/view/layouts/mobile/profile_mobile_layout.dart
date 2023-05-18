
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/widgets/buttons/icon_text_btn.dart';
import 'package:vaea_mobile/view/widgets/buttons/primary_button.dart';
import 'package:vaea_mobile/view/widgets/containers/profile_page_container.dart';

import '../../widgets/modals/language_modal.dart';
import '../../widgets/navigation/adaptive_top_app_bar.dart';
import '../../widgets/navigation/bottom_navigation.dart';

/// It handles the ui interaction for ProfileScreen
class ProfileMobileLayout extends StatefulWidget {

  bool isSignedIn;
  /// a null value indicates that the profile has no image.
  String? profileImageUrl;
  String profileFullName;
  String preSelectedLanguage;
  void Function(String selectedLanguageIso) handleClickLanguage;
  void Function() handleClickSignOut;

  ProfileMobileLayout({
    super.key,
    required this.isSignedIn,
    required this.profileImageUrl,
    required this.profileFullName,
    required this.preSelectedLanguage,
    required this.handleClickLanguage,
    required this.handleClickSignOut
  });

  @override
  State<ProfileMobileLayout> createState() => _ProfileMobileLayoutState();
}

class _ProfileMobileLayoutState extends State<ProfileMobileLayout> {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  // dimensions
  late double btnSpacer;

  /// It is a helper method to build(). It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      btnSpacer = layoutConstraints.maxHeight * 0.01;
    } else if (breakpoint.device.name == "mediumHandset") {
      btnSpacer = layoutConstraints.maxHeight * 0.01;
    } else {
      btnSpacer = layoutConstraints.maxHeight * 0.01;
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        breakpoint = Breakpoint.fromConstraints(constraints);
        layoutConstraints = constraints;
        setupDimensions();

        return Scaffold(
          appBar: AdaptiveTopAppBar(
            currPageTitle: AppLocalizations.of(context)!.profile,
            breakpoint: breakpoint,
            layoutConstraints: constraints,
          ),
          body: (widget.isSignedIn) ? buildSignInBody() : buildVisitor(),
          bottomNavigationBar: BottomNavigation(currentIndex: 3),
        );
      },
    );
  }

  /// It builds the body in case the user was not signed in.
  Widget buildVisitor() {
    return Center(
      child: PrimaryBtn(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        handleClick: () => Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.signIn)),
        buttonText: AppLocalizations.of(context)!.signIn),
    );
  }

  /// It builds the body in case the user was signed in.
  Widget buildSignInBody() {
    return ProfilePageContainer(
        breakpoint: breakpoint,
        layoutBoxConstrains: layoutConstraints,
        imageProfileUrl: widget.profileImageUrl,
        pageTitle: widget.profileFullName,
        btnList: buildSpacedBtns()
    );
  }

  /// It builds a separated buttons for ProfilePageContainer
  List<Widget> buildSpacedBtns() {
    return [
      buildHomeHistoryBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildPaymentBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildNotificationBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildLanguageBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildSignOutBtn()
    ];
  }


  /// It is a helper method to buildSpacedBtns. It builds homes history button.
  Widget buildHomeHistoryBtn() {
    return IconTextBtn(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        handleClick: () {},
        buttonText: AppLocalizations.of(context)!.homesHistory,
        iconData: Icons.history
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds payment button.
  Widget buildPaymentBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () {},
      buttonText: AppLocalizations.of(context)!.payment,
      iconData: Icons.credit_card_rounded
    );
  }

  /// It is a helper method to buildSpacedBtns. It builds notification button.
  Widget buildNotificationBtn() {
    return IconTextBtn(
        breakpoint: breakpoint,
        layoutConstraints: layoutConstraints,
        handleClick: () {},
        buttonText: AppLocalizations.of(context)!.notifications,
        iconData: Icons.notifications
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds language button.
  Widget buildLanguageBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: showLanguageModal,
      buttonText: AppLocalizations.of(context)!.language,
      iconData: Icons.language
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds sign out button.
  Widget buildSignOutBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: widget.handleClickSignOut,
      buttonText: AppLocalizations.of(context)!.signOut,
      iconData: Icons.logout,
      btnColor: Theme.of(context).colorScheme.error,
    );
  }


  /// It handles the event of clicking language to show the language modal
  void showLanguageModal() {
    showModalBottomSheet(
        context: context,
        builder: (_) => LanguageModal(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          preSelectedLanguage: widget.preSelectedLanguage,
          handleChangeLanguage: widget.handleClickLanguage
        )
    );
  }


}