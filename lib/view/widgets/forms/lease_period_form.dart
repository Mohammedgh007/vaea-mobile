
import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';

import '../../../data/enums/lease_period_enum.dart';

/// It builds and manages the form of lease period.
class LeasePeriodForm extends StatefulWidget { // TODO

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;
  void Function(LeasePeriodEnum selectedPeriod, DateTime selectedStartingDate) handleSubmit;

  LeasePeriodForm({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.handleSubmit
  });

  @override
  State<LeasePeriodForm> createState() => _LeasePeriodFormState();
}

class _LeasePeriodFormState extends State<LeasePeriodForm> {

  LeasePeriodEnum selectedPeriod = LeasePeriodEnum.months3;
  DateTime? selectedStartingDate;
  String? startingDateErrorMsg;

  // dimensions
  late double fieldsSpacer;
  late double btnWidth;


  /// It is a helper method for initState(). It initializes the dimensions field.
  void setupDimensions() {
    if (widget.breakpoint.device.name == "smallHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else if (widget.breakpoint.device.name == "mediumHandset") {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    } else {
      fieldsSpacer = widget.layoutConstraints.maxHeight * 0.03;
      btnWidth = widget.layoutConstraints.maxWidth * 0.44;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}
