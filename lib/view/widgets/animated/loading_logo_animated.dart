import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// This widget renders a loading animation for rotation a circle around the app
/// logo.
class LoadingLogoAnimated extends StatefulWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  LoadingLogoAnimated({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints
  });

  @override
  State<LoadingLogoAnimated> createState() => _LoadingLogoAnimatedState();
}

class _LoadingLogoAnimatedState extends State<LoadingLogoAnimated> with TickerProviderStateMixin{

  // circles animation
  late AnimationController _circlesRotationAnimController;
  late AnimationController _topCirclePercentAnimController;

  // logo animation
  late AnimationController _logoSize;

  // dimensions
  late double outlinedCircleRadius;
  late double logoInitialSize;

  @override
  void initState() {
    super.initState();

    setupCirclesAnim();
    setupLogoAnim();

    setupDimensions();
  }


  /// It setups the animation for the rotating circles.
  void setupCirclesAnim() {
    _circlesRotationAnimController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        reverseDuration: const Duration(seconds: 2),
        lowerBound: 0.2,
        upperBound: 1,
    );
    _circlesRotationAnimController.repeat(reverse: true);

    _topCirclePercentAnimController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 3),
        reverseDuration: Duration(seconds: 4),
        lowerBound: 0.3,
        upperBound: 0.9
    );
    _topCirclePercentAnimController.repeat(reverse: true);
  }


  /// It setups the animation controller for the logo animation.
  void setupLogoAnim() {
    _logoSize = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      reverseDuration: const Duration(seconds: 2),
      lowerBound: 0.1,
      upperBound: 0.3,
    );
    _logoSize.repeat(reverse: true);
  }

  /// It setups the dimension used in this widget.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      outlinedCircleRadius = widget.layoutConstraints.maxWidth * 0.4;
      logoInitialSize = widget.layoutConstraints.maxWidth * 0.3;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      outlinedCircleRadius = widget.layoutConstraints.maxWidth * 0.35;
      logoInitialSize = widget.layoutConstraints.maxWidth * 0.25;
    } else {
      outlinedCircleRadius = widget.layoutConstraints.maxWidth * 0.5;
      logoInitialSize = widget.layoutConstraints.maxWidth * 0.4;
    }
  }


  @override
  void dispose() {
    super.dispose();

    _circlesRotationAnimController.stop();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: buildOutlinedCircles()
            ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: buildLogo(),
          )
        )
      ],
    );
  }

  /// It is a helper method. It builds the outlined circles with the animation.
  Widget buildOutlinedCircles() {
    return AnimatedBuilder(
      animation: _circlesRotationAnimController,
      builder: (context, child) {
        return AnimatedRotation(
          turns: _circlesRotationAnimController.value,
          duration: Duration(milliseconds: 500),
          child: SizedBox(
            width: outlinedCircleRadius,
            height: outlinedCircleRadius,
            child: AnimatedBuilder(
              animation: _topCirclePercentAnimController,
              builder: (context, child) {
                return CircularProgressIndicator(
                  value: _topCirclePercentAnimController.value,
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                  backgroundColor: Colors.white70,
                );
              },
            ),
          ),
        );
      },
    );
  }


  /// It is a helper method. It builds the logo with its animation.
  Widget buildLogo() {
    return AnimatedBuilder(
      animation: _logoSize,
      builder: (context, child) {
        return SvgPicture.asset(
          "assets/logos/app_logo_color_transparent.svg",
          height: logoInitialSize + (logoInitialSize * _logoSize.value),
          width: logoInitialSize + (logoInitialSize * _logoSize.value),
        );
      },
    );
  }
}