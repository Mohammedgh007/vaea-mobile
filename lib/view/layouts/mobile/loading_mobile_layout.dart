import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vaea_mobile/view/widgets/animated/loading_logo_animated.dart';
import 'package:vaea_mobile/view/widgets/containers/loading_splash_container.dart';

/// It sets the view layout for the screens that needs only a logo and loading
/// animation.
class LoadingMobileLayout extends StatelessWidget {
  final String? displayedText;

  const LoadingMobileLayout({super.key, this.displayedText});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      final breakpoint = Breakpoint.fromConstraints(constraints);

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          body: Container(
            color: Theme.of(ctx).colorScheme.onPrimaryContainer,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: (this.displayedText == null)
                  ? SplashContainer(
                      breakpoint: breakpoint, layoutConstraints: constraints)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SplashContainer(
                            breakpoint: breakpoint,
                            layoutConstraints: constraints)
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }
}
