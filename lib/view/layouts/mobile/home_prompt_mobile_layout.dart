
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/data/enums/home_type.dart';
import 'package:vaea_mobile/view/widgets/navigation/adaptive_top_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vaea_mobile/view/widgets/navigation/bottom_navigation.dart';

import '../../../data/enums/city_name.dart';
import '../../../data/enums/gender.dart';
import '../../widgets/buttons/rect_img_button.dart';

/// It handles the ui interaction for HomePromptScreen
class HomePromptMobileLayout extends StatefulWidget {

  void Function(HomeType selectedHomeType) saveHomeType;
  void Function(Gender selectedGender) saveTenantGender;
  void Function(CityName selectedCityName) submitCityName;

  HomePromptMobileLayout({
    super.key,
    required this.saveHomeType,
    required this.saveTenantGender,
    required this.submitCityName
  });


  @override
  State<HomePromptMobileLayout> createState() => _HomePromptMobileLayout();
}

class _HomePromptMobileLayout extends State<HomePromptMobileLayout> {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;
  final PageController pageController = PageController(initialPage: 0);


  // dimensions
  late double topPadding;
  late double horizontalPadding;
  late double homeTypeImageSize;
  late double homeTypeTextAreaWidth;
  late double TypeOptionIconSize;
  late double cityNameImageSize;
  late double? selectPromptFontSize;
  late double? typeOptionTitleFontSize;
  late double? homeTypeSubtitleFontSize;
  late double? selectPromptSpacer;
  late double? homeTypesOptionsSpacer;

  /// It is a helper method to build(). It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      topPadding = layoutConstraints.maxHeight * 0.02;
      horizontalPadding = layoutConstraints.maxWidth * 0.04;
      homeTypeImageSize = layoutConstraints.maxWidth * 0.25;
      homeTypeTextAreaWidth = layoutConstraints.maxWidth * 0.46;
      TypeOptionIconSize = layoutConstraints.maxWidth * 0.13;
      cityNameImageSize = layoutConstraints.maxWidth * 0.43;
      selectPromptFontSize = Theme.of(context).textTheme.headlineMedium!.fontSize;
      typeOptionTitleFontSize = Theme.of(context).textTheme.titleLarge!.fontSize;
      homeTypeSubtitleFontSize = Theme.of(context).textTheme.bodySmall!.fontSize;
      selectPromptSpacer = layoutConstraints.maxHeight * 0.055;
      homeTypesOptionsSpacer = layoutConstraints.maxHeight * 0.026;
    } else if (breakpoint.device.name == "mediumHandset") {
      topPadding = layoutConstraints.maxHeight * 0.1;
      horizontalPadding = layoutConstraints.maxWidth * 0.04;
      homeTypeImageSize = layoutConstraints.maxWidth * 0.25;
      homeTypeTextAreaWidth = layoutConstraints.maxWidth * 0.46;
      TypeOptionIconSize = layoutConstraints.maxWidth * 0.13;
      cityNameImageSize = layoutConstraints.maxWidth * 0.43;
      selectPromptFontSize = Theme.of(context).textTheme.headlineMedium!.fontSize;
      typeOptionTitleFontSize = Theme.of(context).textTheme.headlineSmall!.fontSize;
      homeTypeSubtitleFontSize = Theme.of(context).textTheme.bodyMedium!.fontSize;
      selectPromptSpacer = layoutConstraints.maxHeight * 0.055;
      homeTypesOptionsSpacer = layoutConstraints.maxHeight * 0.026;
    } else {
      topPadding = layoutConstraints.maxHeight * 0.1;
      horizontalPadding = layoutConstraints.maxWidth * 0.04;
      homeTypeImageSize = layoutConstraints.maxWidth * 0.25;
      homeTypeTextAreaWidth = layoutConstraints.maxWidth * 0.46;
      TypeOptionIconSize = layoutConstraints.maxWidth * 0.13;
      cityNameImageSize = layoutConstraints.maxWidth * 0.43;
      selectPromptFontSize = Theme.of(context).textTheme.headlineMedium!.fontSize;
      typeOptionTitleFontSize = Theme.of(context).textTheme.headlineSmall!.fontSize;
      homeTypeSubtitleFontSize = Theme.of(context).textTheme.bodyMedium!.fontSize;
      selectPromptSpacer = layoutConstraints.maxHeight * 0.055;
      homeTypesOptionsSpacer = layoutConstraints.maxHeight * 0.026;
    }
  }

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      breakpoint = Breakpoint.fromConstraints(constraints);
      layoutConstraints = constraints;
      setupDimensions();

      return Scaffold(
        appBar: AdaptiveTopAppBar(
          breakpoint: breakpoint,
          layoutConstraints: layoutConstraints,
          currPageTitle: AppLocalizations.of(context)!.home
        ),
        body: PageView(
          controller: pageController,
          children: [
            buildHomeTypePrompt(),
            //buildTenantGenderPrompt(),
            buildCityNamePrompt(),
          ],
          physics: const NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigation(currentIndex: 0),
      );
    });
  }

  /// It builds the page view for the home type prompt
  Widget buildHomeTypePrompt() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: topPadding, right: horizontalPadding, left: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppLocalizations.of(context)!.selectHomeType,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight,
              ),
            ),
          ),
          SizedBox(height: selectPromptSpacer),
          buildTypeOption(
            "assets/images/entire_home_option.png",
            AppLocalizations.of(context)!.entireHomeTitle,
            AppLocalizations.of(context)!.entireHomeSubtitle,
            () => handleSelectHomeType(HomeType.private)
          ),
          SizedBox(height: homeTypesOptionsSpacer),
          buildTypeOption(
            "assets/images/share_home_option.png",
            AppLocalizations.of(context)!.sharedHomeTitle,
            AppLocalizations.of(context)!.sharedHomeSubtitle,
            () => handleSelectHomeType(HomeType.shared)
          ),
        ],
      ),
    );
  }


  /// It builds the page view for the tenant gender
  Widget buildTenantGenderPrompt() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: topPadding, right: horizontalPadding, left: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              AppLocalizations.of(context)!.selectTenantGender,
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
                fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight,
              ),
            ),
          ),
          SizedBox(height: selectPromptSpacer),
          buildTypeOption(
            "assets/images/male_tenant_option.png",
            AppLocalizations.of(context)!.maleTenantGenderTitle,
            AppLocalizations.of(context)!.maleTenantGenderSubTitle,
            () => handleSelectTenantGender(Gender.male)
          ),
          SizedBox(height: homeTypesOptionsSpacer),
          buildTypeOption(
            "assets/images/female_tenant_option.png",
            AppLocalizations.of(context)!.femaleTenantGenderTitle,
            AppLocalizations.of(context)!.femaleTenantGenderSubTitle,
            () => handleSelectTenantGender(Gender.female)
          ),
        ],
      ),
    );
  }


  /// It builds a home type option card and a tenant gender type card
  Widget buildTypeOption(String imagePath, String homeTypeTitle,
      String homeTypeSubtitle, void Function() handleSelect) {
    return GestureDetector(
      onTap: handleSelect,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTypeOptionImage(imagePath),
          buildTypeOptionText(homeTypeTitle, homeTypeSubtitle),
          buildOptionIcon()
        ],
      ),
    );
  }


  /// It is a helper method for buildTypeOption. It builds the leading image.
  Widget buildTypeOptionImage(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(homeTypeImageSize * 0.1),
      child: Image.asset(
        imagePath,
        width: homeTypeImageSize,
        height: homeTypeImageSize,
        fit: BoxFit.fill,
      ),
    );
  }


  /// It is a helper method for buildHomeTypeOption. It builds the text area section.
  Widget buildTypeOptionText(String title, String subTitle) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: homeTypeImageSize,
        maxHeight: homeTypeImageSize,
        maxWidth: homeTypeTextAreaWidth
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                fontSize: typeOptionTitleFontSize,
                fontWeight: Theme.of(context).textTheme.headlineSmall!.fontWeight,
                color: Theme.of(context).colorScheme.primary
              ),
            ),
          ),
          SizedBox(height: 5),
          Text(
            subTitle,
            softWrap: true,
            style: TextStyle(
              fontSize: homeTypeSubtitleFontSize,
              fontWeight: Theme.of(context).textTheme.bodyMedium!.fontWeight,
              color: Theme.of(context).colorScheme.outlineVariant
            ),
          ),
        ],
      ),
    );
  }


  /// It is a helper method for buildHoeTypeOption.
  Widget buildOptionIcon() {
    return Container(
        width: TypeOptionIconSize,
        height: TypeOptionIconSize * 0.62,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(TypeOptionIconSize * 0.2)
        ),
        child: (AppLocalizations.of(context)!.localeName == "ar")
            ? Transform(
            transform: Matrix4.rotationY(180),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_right_alt_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
              size: TypeOptionIconSize * 0.62,
            )
        )
            : Icon(
          Icons.arrow_right_alt_rounded,
          color: Theme.of(context).colorScheme.onPrimary,
          size: TypeOptionIconSize * 0.62,
        )
    );
  }


  /// It builds the page view for the city name prompt
  Widget buildCityNamePrompt() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: topPadding, right: horizontalPadding, left: horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.selectTheCity,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize,
              fontWeight: Theme.of(context).textTheme.headlineMedium!.fontWeight,
            ),
          ),
          SizedBox(height: selectPromptSpacer),
          Wrap(
            children: buildCityNameBtns(),
            spacing: layoutConstraints.maxWidth - (cityNameImageSize * 2 + horizontalPadding * 2),
            runSpacing: layoutConstraints.maxWidth - (cityNameImageSize * 2 + horizontalPadding * 2),
          )
        ],
      ),
    );
  }

  /// It is a helper method for buildHomeTypePrompt. It builds the list of
  /// city name buttons.
  List<Widget> buildCityNameBtns() {
    return [
      buildCityNameOption(
        "assets/images/riyadh_city.png",
        AppLocalizations.of(context)!.riyadh,
        CityName.riyadh
      ),
      Opacity(
        opacity: 0.3,
        child: buildCityNameOption(
            "assets/images/jeddah_city.png",
            AppLocalizations.of(context)!.jeddah,
            CityName.jeddah
        ),
      ),
      Opacity(
        opacity: 0.3,
        child: buildCityNameOption(
            "assets/images/khobar_city.png",
            AppLocalizations.of(context)!.khobar,
            CityName.khobar
        ),
      )
    ];
  }


  /// It is a helper method for buildCityNamePrompt. It builds a city name image.
  Widget buildCityNameOption(String imagePath, String cityName, CityName cityNameVal) {
    return RectImgButton(
      breakpoint: breakpoint,
      layoutConstraints: layoutConstraints,
      isImageAsset: true,
      imagePath: imagePath,
      buttonText: cityName,
      buttonSize: cityNameImageSize,
      handleClick: () {
        if (cityNameVal == CityName.riyadh) {
          widget.submitCityName(cityNameVal);
        }
      },
    );
  }


  /// It handles selecting home type option by saving the input then take the
  /// user to the next PageView.
  void handleSelectHomeType(HomeType selectedType) {
    pageController.jumpToPage(1);
    widget.saveHomeType(selectedType);
    debugPrint("ffff ${selectedType.toString()}");

  }


  /// It handles selecting the tenant gender option by saving the input then take
  /// the user to the next page.
  void handleSelectTenantGender(Gender selectedGender) {
    pageController.jumpToPage(2);
    widget.saveTenantGender(selectedGender);
  }




}