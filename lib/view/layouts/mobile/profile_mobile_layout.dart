
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/widgets/alerts/account_termination_alert.dart';
import 'package:vaea_mobile/view/widgets/buttons/icon_text_btn.dart';

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
  void Function() handleClickSignIn;
  void Function() handleClickSignOut;

  ProfileMobileLayout({
    super.key,
    required this.isSignedIn,
    required this.profileImageUrl,
    required this.profileFullName,
    required this.preSelectedLanguage,
    required this.handleClickLanguage,
    required this.handleClickSignIn,
    required this.handleClickSignOut
  });

  @override
  State<ProfileMobileLayout> createState() => _ProfileMobileLayoutState();
}

class _ProfileMobileLayoutState extends State<ProfileMobileLayout> {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  // dimensions
  late double bodyPadding;
  late double imageSectionHeight;
  late double profileAvatarSize;
  late double btnSpacer;

  /// It is a helper method to build(). It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      bodyPadding = layoutConstraints.maxWidth * 0.08;
      profileAvatarSize = layoutConstraints.maxWidth * 0.32;
      imageSectionHeight = profileAvatarSize * 2;
      btnSpacer = layoutConstraints.maxHeight * 0.01;
    } else if (breakpoint.device.name == "mediumHandset") {
      bodyPadding = layoutConstraints.maxWidth * 0.08;
      profileAvatarSize = layoutConstraints.maxWidth * 0.32;
      imageSectionHeight = profileAvatarSize * 2;
      btnSpacer = layoutConstraints.maxHeight * 0.01;
    } else {
      bodyPadding = layoutConstraints.maxWidth * 0.08;
      profileAvatarSize = layoutConstraints.maxWidth * 0.32;
      imageSectionHeight = profileAvatarSize * 2;
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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: bodyPadding),
            child: buildBody(),
          ),
          bottomNavigationBar: BottomNavigation(currentIndex: 3),
        );
      },
    );
  }


  /// It builds the body in case the user was signed in.
  Widget buildBody() {
    return SizedBox(
      width: layoutConstraints.maxWidth,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProfileImageSection(),
            ...buildSpacedBtns()
          ],
        ),
      ),
    );
  }

  /// It builds the profile image section that includes a center avatar and the full name.
  Widget buildProfileImageSection() {
    return Container(
      width: layoutConstraints.maxWidth,
      height: imageSectionHeight,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 3),
              borderRadius: BorderRadius.circular(layoutConstraints.maxHeight)
            ),
            child: ClipOval(
              child: (widget.isSignedIn && widget.profileImageUrl != null)
                ? Image.network(widget.profileImageUrl!, width: profileAvatarSize, height: profileAvatarSize, fit: BoxFit.fill)
                : Image.asset("assets/logos/profile_logo.png", width: profileAvatarSize, height: profileAvatarSize, fit: BoxFit.fill),
            ),
          ),
          if (widget.isSignedIn) SizedBox(height: profileAvatarSize * 0.1),
          if (widget.isSignedIn) Text(
            widget.profileFullName,
            style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize),
          )
        ],
      ),
    );
  }

  /// It builds a separated buttons for ProfilePageContainer
  List<Widget> buildSpacedBtns() {
    return [
      if (!widget.isSignedIn) Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      if (!widget.isSignedIn) buildSignInBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildHomeHistoryBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildPaymentBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildNotificationBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildLanguageBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      buildTermsConditionBtn(),
      Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      if (widget.isSignedIn) buildSignOutBtn(),
      if (widget.isSignedIn) Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
      if (widget.isSignedIn) buildTerminateBtn(),
      if (widget.isSignedIn) Divider(height: btnSpacer, color: Theme.of(context).colorScheme.outline),
    ];
  }


  /// It is a helper method for buildSpacedBtns. It builds the sign in button.
  Widget buildSignInBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: widget.handleClickSignIn,
      buttonText: AppLocalizations.of(context)!.signIn,
      iconData: Icons.login,
      includeNextIcon: true,
    );
  }

  /// It is a helper method to buildSpacedBtns. It builds homes history button.
  Widget buildHomeHistoryBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () {},
      buttonText: AppLocalizations.of(context)!.homesHistory,
      iconData: Icons.history,
      includeNextIcon: true,
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds payment button.
  Widget buildPaymentBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () {},
      buttonText: AppLocalizations.of(context)!.payment,
      iconData: Icons.credit_card_rounded,
      includeNextIcon: true,
    );
  }

  /// It is a helper method to buildSpacedBtns. It builds notification button.
  Widget buildNotificationBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () {},
      buttonText: AppLocalizations.of(context)!.notifications,
      iconData: Icons.notifications,
      includeNextIcon: true,
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds language button.
  Widget buildLanguageBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: showLanguageModal,
      buttonText: AppLocalizations.of(context)!.language,
      iconData: Icons.language,
      includeNextIcon: true,
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds terms and condition button.
  Widget buildTermsConditionBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () => Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.termsConditions)),
      buttonText: AppLocalizations.of(context)!.termAndCondition,
      iconData: Icons.policy_outlined,
      includeNextIcon: true,
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
      includeNextIcon: true,
    );
  }


  /// It is a helper method to buildSpacedBtns. It builds account termination button.
  Widget buildTerminateBtn() {
    return IconTextBtn(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      handleClick: () {
        showDialog(context: context, builder: (_) => AccountTerminationAlert());
      },
      buttonText: AppLocalizations.of(context)!.deleteAccount,
      iconData: Icons.person_remove_rounded,
      btnColor: Theme.of(context).colorScheme.error,
      includeNextIcon: true,
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