

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../widgets/navigation/adaptive_top_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/navigation/bottom_navigation.dart';

/// this screen is a static screen that shows the terms and conditions of vaea
/// that include privacy policy and refund policy.
class TermsConditionScreen extends StatelessWidget {

  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        breakpoint = Breakpoint.fromConstraints(constraints);
        layoutConstraints = constraints;

        return Scaffold(
          appBar: AdaptiveTopAppBar(
            currPageTitle: AppLocalizations.of(context)!.termAndCondition,
            breakpoint: breakpoint,
            layoutConstraints: constraints,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: layoutConstraints.maxWidth * 0.04, vertical: layoutConstraints.maxWidth * 0.02),
            children: [
              ...buildPrivacySection(context),
              SizedBox(height: 20),
              ...buildRefundSection(context)
            ],
          ),
        );
      },
    );
  }


  /// It builds the privacy section.
  List<Widget> buildPrivacySection(BuildContext context) {
    return [
      Text(
        AppLocalizations.of(context)!.privacyPolicy,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize
        ),
      ),
      SizedBox(height: 10),
      SelectableText(
        AppLocalizations.of(context)!.privacyPolicyBody,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
        ),
      )
    ];
  }


  /// It builds the refund section.
  List<Widget> buildRefundSection (BuildContext context) {
    return [
      Text(
        AppLocalizations.of(context)!.refundPolicy,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.headlineMedium!.fontSize
        ),
      ),
      SizedBox(height: 10),
      SelectableText(
        AppLocalizations.of(context)!.refundPolicyBody,
        style: TextStyle(
            fontSize: Theme.of(context).textTheme.bodyMedium!.fontSize
        ),
      )
    ];
  }


}