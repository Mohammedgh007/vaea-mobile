
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AdaptiveTopAppBar extends StatelessWidget implements PreferredSize {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  String currPageTitle;
  String? previousPageTitle;
  List<Widget>? trailingWidgets;

  // dimensions
  late double barHeight;

  AdaptiveTopAppBar({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.currPageTitle,
    this.previousPageTitle,
    this.trailingWidgets
  }){
    setupDimensions();
  }

  /// It is a helper method for the constructor. It setups the dimensions.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      barHeight = layoutConstraints.maxHeight * 0.07;
    } else if (breakpoint.device.name == "mediumHandset") {
      barHeight = layoutConstraints.maxHeight * 0.07;
    } else {
      barHeight = layoutConstraints.maxHeight * 0.07;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isAndroid) {
      return buildAndroidVariation(context);
    } else {
      return buildIosVariation(context);
    }
  }

  /// It builds the material top app bar
  Widget buildAndroidVariation(BuildContext context) {
    return AppBar(
      title: Text(currPageTitle),
      automaticallyImplyLeading: previousPageTitle != null,
      actions: trailingWidgets,
    );
  }


  /// It builds cupertino variation that is navigation bar.
  Widget buildIosVariation(BuildContext context) {

    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.onSurface,
      title: Text(currPageTitle),
      centerTitle: true,
      // leading: (previousPageTitle != null)
      //     ? CupertinoNavigationBarBackButton(previousPageTitle: previousPageTitle)
      //     : null,
      automaticallyImplyLeading: (previousPageTitle != null),
      actions: trailingWidgets,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(barHeight);

  @override
  // TODO: implement child
  Widget get child => const SizedBox();


}