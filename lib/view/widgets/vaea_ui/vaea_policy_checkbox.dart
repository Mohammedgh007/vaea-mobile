
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// It builds the checkbox with its associated text that is used for assuring the
/// user has accepted a given policy. Optionally, this widget can open the policy
/// as a modal when the user click on the policy name.
class VAEAPolicyCheckBox extends StatelessWidget {

  String prePolicyNameText;
  String policyNameText;
  String postPolicyNameText;
  bool hasChecked;
  void Function(bool hasChecked) handleChangeHasChanged;
  PolicyPopupWindowType? popupType;
  String? policyUrl; // if popupType is webpage

  VAEAPolicyCheckBox({
    super.key,
    required this.prePolicyNameText,
    required this.policyNameText,
    required this.postPolicyNameText,
    required this.hasChecked,
    required this.handleChangeHasChanged,
    this.popupType,
    this.policyUrl
  });

   @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: buildText(context),
      controlAffinity: ListTileControlAffinity.leading,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      value: hasChecked,
      onChanged: (bool? isChecked) {
        if (isChecked != null) {
          handleChangeHasChanged(isChecked);
        }
      }
    );
  }


  /// It builds the associated text with the checkbox.
  Widget buildText(BuildContext context) {
     return Text.rich(TextSpan(
       style: TextStyle(fontSize: Theme.of(context).textTheme.bodySmall!.fontSize),
       children: [
         TextSpan(
           text: prePolicyNameText,
           style: TextStyle(color: Theme.of(context).colorScheme.onBackground)
         ), TextSpan(
             text: policyNameText,
             style: TextStyle(color: Theme.of(context).colorScheme.primary),
           recognizer: TapGestureRecognizer()..onTap = () {handleClickPolicyName();}
         ), TextSpan(
             text: postPolicyNameText,
             style: TextStyle(color: Theme.of(context).colorScheme.onBackground)
         )
       ]
     ));
  }

  /// It handles the event of clicking the policy name
  void handleClickPolicyName() {
     if (popupType == PolicyPopupWindowType.webpage) {
       Uri uri = Uri.parse(policyUrl!);
       launchUrl(uri);
     }
  }
}


enum PolicyPopupWindowType {
  webpage, appScreen
}
