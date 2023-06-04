import 'dart:io';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:vaea_mobile/view/widgets/navigation/adaptive_top_app_bar.dart';

import '../../data/enums/services_enums.dart';
import '../../routes_mapper.dart';
import '../style/colors.dart';
import '../widgets/navigation/bottom_navigation.dart';

/// This class handles the view and its interactions with the rest of app
/// for services screen.
class ServicesList extends StatefulWidget {
  const ServicesList({super.key});

  @override
  State<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
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
          previousPageTitle: "",
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 19.h),
                  child: Text(
                    AppLocalizations.of(context)!.selectTheService,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.lightOnBackground,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Wrap(
                runSpacing: 20,
                spacing: 20,
                alignment: WrapAlignment.start,
                children: [
                  ServiceItem(service: ServicesTypes.values[0]),
                  ServiceItem(service: ServicesTypes.values[1]),
                  ServiceItem(service: ServicesTypes.values[2])
                ],
              ),
            ),
            // Expanded(
            //   child: GridView.builder(
            //     primary: false,
            //     padding: const EdgeInsets.all(20),
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisSpacing: 10,
            //       mainAxisSpacing: 10,
            //       crossAxisCount: 2,
            //     ),
            //     itemBuilder: (context, index) =>
            //         ServiceItem(service: ServicesTypes.values[index]),
            //     itemCount: 1,
            //   ),
            // ),
          ],
        ),
        bottomNavigationBar: BottomNavigation(currentIndex: 2),
      );
    });
  }
}

class ServiceItem extends StatelessWidget {
  final ServicesTypes service;
  const ServiceItem({super.key, required this.service});

  String mapTypeToTitle(BuildContext context) {
    switch(service) {
      case ServicesTypes.houseCleaning:
        return AppLocalizations.of(context)!.houseCleaning;
      case ServicesTypes.plumbing:
        return AppLocalizations.of(context)!.plumbing;
      default: //case ServicesTypes.electrician:
        return AppLocalizations.of(context)!.electrician;

    }
  }

  String mapTypeToDisc(BuildContext context) {
    switch(service) {
      case ServicesTypes.houseCleaning:
        return AppLocalizations.of(context)!.houseCleaningDisc;
      case ServicesTypes.plumbing:
        return AppLocalizations.of(context)!.plumbingDisc;
      default: //case ServicesTypes.electrician:
        return AppLocalizations.of(context)!.electricianDisc;

    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
            RoutesMapper.getScreenRoute(
              ScreenName.servicesListScreen,
            ),
            arguments: service);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightSecondary),
          borderRadius: BorderRadius.circular(18),
        ),
        width: 170.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Image.asset(
                service.image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.0.h, bottom: 7.h),
              child: Center(
                child: Text(
                  mapTypeToTitle(context),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.lightPrimary, fontFamily: 'Montserrat'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only( bottom: 12.h),
              child: Text(
                mapTypeToDisc(context),
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontFamily: 'Montserrat',
                      overflow: TextOverflow.clip,
                    ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
