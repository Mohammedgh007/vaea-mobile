
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:vaea_mobile/view/widgets/navigation/adaptive_top_app_bar.dart';

import '../widgets/navigation/bottom_navigation.dart';

/// This class handles the view and its interactions with the rest of app
/// for services screen.
class ServicesScreen extends StatefulWidget {

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {


  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        Breakpoint breakpoint = Breakpoint.fromConstraints(constraints);
        return Scaffold(
          appBar: AdaptiveTopAppBar(
            breakpoint: breakpoint,
            layoutConstraints: constraints,
            currPageTitle: AppLocalizations.of(context)!.services,
          ),
          body: Text("Comming soon"),
          bottomNavigationBar: BottomNavigation(currentIndex: 2),
        );
      }
    );
  }


}

