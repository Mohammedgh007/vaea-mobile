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
        floatingActionButton: (Platform.isAndroid)
            ? FloatingActionButton(
                backgroundColor: AppColors.lightPrimary,
                onPressed: () {},
                child: const Icon(
                  Icons.add,
                  size: 40,
                ),
              )
            : null,
        appBar: AdaptiveTopAppBar(
          breakpoint: breakpoint,
          layoutConstraints: constraints,
          currPageTitle: AppLocalizations.of(context)!.services,
          trailingWidgets: (Platform.isIOS)
              ? const [Center(child: Text('Add Request'))]
              : null,
        ),
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 19.h),
                  child: Text(
                    'Select the Service',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        color: AppColors.lightOnBackground,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Montserrat'),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) =>
                    ServiceItem(service: ServicesTypes.values[index]),
                itemCount: ServicesTypes.values.length,
              ),
            ),
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
                  service.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppColors.lightPrimary, fontFamily: 'Montserrat'),
                ),
              ),
            ),
            Expanded(
              child: Text(
                service.description,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontFamily: 'Montserrat',
                      overflow: TextOverflow.clip,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
