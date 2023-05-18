
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/providers/home_search_provider.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/home_prompt_mobile_layout.dart';

import '../../data/enums/city_name.dart';
import '../../data/enums/home_type.dart';

/// This class handles the view and its interactions with the rest of app
/// for home prompt screen.
class HomePromptScreen extends StatefulWidget {

  HomePromptScreen({super.key});


  @override
  State<HomePromptScreen> createState() => _HomePromptScreenState();
}

class _HomePromptScreenState extends State<HomePromptScreen> {

  late final HomeSearchProvider searchProvider;


  @override
  void initState() {
    super.initState();

    searchProvider = Provider.of<HomeSearchProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {

    return HomePromptMobileLayout(
      saveHomeType: saveSelectedHomeType,
      submitCityName: submitSelectedCityName
    );
  }


  /// It saves the input home type to the filters of search
  void saveSelectedHomeType(HomeType selectedHomeType) {
    searchProvider.filters.homeType = selectedHomeType;
  }

  /// It saves the input city name to the filters of search then navigates the
  /// user to the search screen.
  void submitSelectedCityName(CityName selectedCityName) {
    searchProvider.filters.cityName = selectedCityName;
    Navigator.of(context).pushNamed(RoutesMapper.getScreenRoute(ScreenName.homeSearch));
  }

}