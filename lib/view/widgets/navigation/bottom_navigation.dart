
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../routes_mapper.dart';

/// It creates the bottom navigation bar for ios and Android on the mobile version.
class BottomNavigation extends StatelessWidget {

  int currentIndex;

  BottomNavigation({
    super.key,
    required this.currentIndex
  });


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          width: 1
        ))
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon((currentIndex == 0) ? Icons.home : Icons.home_outlined),
            label: AppLocalizations.of(context)!.home
          ),
          BottomNavigationBarItem(
            icon: Icon((currentIndex == 1) ? Icons.groups : Icons.groups_outlined),
            label: AppLocalizations.of(context)!.activities
          ),
          BottomNavigationBarItem(
            icon: Icon((currentIndex == 2) ? Icons.build : Icons.build_outlined),
            label: AppLocalizations.of(context)!.services
          ),
          BottomNavigationBarItem(
            icon: Icon((currentIndex == 3) ? Icons.account_circle_sharp : Icons.account_circle_outlined),
            label: AppLocalizations.of(context)!.profile
          )
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedItemColor: const Color.fromRGBO(28, 79, 125, 1),
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        showUnselectedLabels: true,
        onTap: (int index) => handleSelectNavBtn(index, context),
      ),
    );
  }


  /// It handles the event of clicking on a navigation button.
  void handleSelectNavBtn(int index, BuildContext context) {
    List<ScreenName> screens = [
      ScreenName.home,
      ScreenName.activities,
      ScreenName.services,
      ScreenName.profile
    ];

    PageTransition pageTran = PageTransition(
      child: RoutesMapper.getScreenWidget(screens[index]),
      type: PageTransitionType.bottomToTop
    );
    Navigator.of(context).push(pageTran);
  }

}