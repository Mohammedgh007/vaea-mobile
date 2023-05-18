import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:vaea_mobile/view/widgets/animated/loading_logo_animated.dart';

/// It sets the view layout for the screens that needs only a logo and loading
/// animation.
class LoadingMobileLayout extends StatelessWidget {

  final String? displayedText;

  const LoadingMobileLayout({
    super.key,
    this.displayedText
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext ctx, BoxConstraints constraints) {
        final breakpoint = Breakpoint.fromConstraints(constraints);

        return Scaffold(
          body: Container(
            color: Theme.of(ctx).colorScheme.tertiary,
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: (this.displayedText == null)
                  ? LoadingLogoAnimated(breakpoint: breakpoint, layoutConstraints: constraints)
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LoadingLogoAnimated(breakpoint: breakpoint, layoutConstraints: constraints)
                ],
              ),
            ),
          ),
        );
      }
    );
  }
}
