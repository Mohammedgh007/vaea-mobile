import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashContainer extends StatefulWidget {
  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  SplashContainer(
      {Key? key, required this.breakpoint, required this.layoutConstraints})
      : super(key: key);

  @override
  State<SplashContainer> createState() => _SplashContainerState();
}

class _SplashContainerState extends State<SplashContainer>
    with TickerProviderStateMixin {
  late AnimationController _circularIndicatorAnimController;

  // dimensions
  late double circularIndicatorSize;
  late double logoInitialSize;

  @override
  void initState() {
    super.initState();

    setupCirclesAnim();

    setupDimensions();
  }

  /// It setups the animation for the rotating circles.
  void setupCirclesAnim() {
    _circularIndicatorAnimController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _circularIndicatorAnimController.repeat();
  }

  /// It setups the dimension used in this widget.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      circularIndicatorSize = widget.layoutConstraints.maxWidth * 0.06;
      logoInitialSize = widget.layoutConstraints.maxWidth * 0.3;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      circularIndicatorSize = widget.layoutConstraints.maxWidth * 0.06;
      logoInitialSize = widget.layoutConstraints.maxWidth * 0.3;
    } else {
      circularIndicatorSize = widget.layoutConstraints.maxWidth * 0.06;
      logoInitialSize = widget.layoutConstraints.maxWidth * 0.3;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _circularIndicatorAnimController.stop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 80,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: buildOutlinedCircles(),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: buildLogo(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildOutlinedCircles() {
    return SizedBox(
      height: circularIndicatorSize,
      width: circularIndicatorSize,
      child: CircularProgressIndicator(
        valueColor: _circularIndicatorAnimController.drive(
          ColorTween(
            begin: const Color(0xFFF492A1),
            end: const Color(0xFFBF90F0),
          ),
        ),
        backgroundColor: Colors.transparent,
        strokeWidth: 2.5,
      ),
    );
  }

  /// It is a helper method. It builds the logo
  Widget buildLogo() {
    return SvgPicture.asset(
      "assets/logos/temp_icon_svg.svg",
      width: logoInitialSize,
    );
  }
}
