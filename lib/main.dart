import 'dart:ui';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vaea_mobile/bloc/providers/booking_provider.dart';
import 'package:vaea_mobile/bloc/providers/home_search_provider.dart';
import 'package:vaea_mobile/bloc/providers/launch_requirements_provider.dart';
import 'package:vaea_mobile/bloc/providers/profile_provider.dart';
import 'package:vaea_mobile/bloc/providers/user_settings_provider.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/screens/spash_screen.dart';

import 'bloc/providers/activities_provider.dart';
import 'bloc/providers/services_provider.dart';

void main() async {
  // loading env variables
  if (kReleaseMode) {
    await dotenv.load(fileName: ".env.dev");
    //await dotenv.load(fileName: ".env.test");
  } else {
    await dotenv.load(fileName: ".env.dev");
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Retrieve locale from the system information.
    Locale myLocale = window.locale;

    return MultiProvider(
      providers: getProvidersList(),
      child: Consumer<UserSettingsProvider>(
        builder: (context, value, child) => ScreenUtilInit(
          designSize: const Size(390, 844),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            title: 'VAEA',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
            ],
            locale: (value.userSettingsModel != null &&
                    value.userSettingsModel!.languageCode != null)
                ? Locale(value.userSettingsModel!.languageCode!)
                : Locale("ar"),
            onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.appName,
            theme: ThemeData(
              colorScheme: getColorScheme(),
              fontFamily:
                  (myLocale.languageCode == "en") ? "Kollektif" : "29LTZawi",
            ),
            home: SplashScreen(),
            onGenerateRoute: (settings) {
              return PageTransition(
                  child: RoutesMapper.screensMap[settings.name]!,
                  type: (AppLocalizations.of(context)?.localeName == "ar")
                      ? PageTransitionType.leftToRight
                      : PageTransitionType.rightToLeft,
                  duration: const Duration(milliseconds: 300),
                  settings: settings);
            },
          ),
        ),
      ),
    );
  }

  /// It is a helper method for main. it sets the list of provider.
  List<SingleChildWidget> getProvidersList() {
    return [
      ChangeNotifierProvider(create: (_) => UserSettingsProvider()),
      ChangeNotifierProvider(create: (_) => LaunchRequirementsProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider(create: (_) => HomeSearchProvider()),
      ChangeNotifierProvider(create: (_) => BookingProvider()),
      ChangeNotifierProvider(create: (_) => ServicesProvider()),
      ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
    ];
  }

  /// It is a helper method for main. It sets the color scheme theme.
  ColorScheme getColorScheme() {
    return const ColorScheme(
        // primary: Color(0xFF1D2C59),
        // onPrimary: Color(0xffffffff),
        // primaryContainer: Color(0xFF1B1B1F),
        // onPrimaryContainer: Color(0xFF00164D),
        // secondary: Color(0xff6DA9DE),
        // onSecondary: Color(0xFF010101),
        // secondaryContainer: Color(0xFFC1DAF1),
        // onSecondaryContainer: Color(0xFF1C4F7D),
        // tertiary: Color(0xFFB8E6F3),
        // onTertiary: Color(0xFF343434),
        primary: Color.fromRGBO(87, 78, 174, 1),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFE4DFFF),
        onPrimaryContainer: Color(0xFF150066),
        secondary: Color.fromRGBO(107, 136, 243, 1),
        onSecondary: Color(0xFFFFFFFF),
        secondaryContainer: Color(0xFFDCE1FF),
        onSecondaryContainer: Color(0xFF001551),
        tertiary: Color.fromRGBO(242, 153, 113, 1),
        onTertiary: Color(0xFFFFFFFF),
        tertiaryContainer: Color(0xFFFFDBCD),
        onTertiaryContainer: Color(0xFF360F00),
        background: Color(0xFFFFFFFF),
        onBackground: Color.fromRGBO(52, 52, 52, 1),
        outline: Color(0xFF8F909A),
        surface: Color(0xFFF5F5F5),
        onSurface: Color(0xFF1B1B1F),
        onSurfaceVariant: Color(0xFF45464F),
        error: Color.fromRGBO(247, 105, 132, 1),
        onError: Color(0xFFFFFFFF),
        brightness: Brightness.light,
        outlineVariant: Color.fromRGBO(82, 82, 96, 1.0) // medium emphasis text
        );
  }

  /// It is a helper method for main. It sets TextTheme
  TextTheme getTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(fontSize: 57.sp, fontWeight: FontWeight.w400),
      displayMedium: TextStyle(fontSize: 45.sp, fontWeight: FontWeight.w400),
      displaySmall: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w400),
      headlineMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w400),
      headlineSmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
      titleLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w800),
      titleMedium: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal),
    );
  }
}
