
import 'package:breakpoint/breakpoint.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';

/// It builds a horizontal stepper based on vaea theme.
class VAEAStepper extends StatelessWidget {

  Breakpoint breakpoint;
  BoxConstraints layoutConstraints;

  List<String> stepsNames;
  int currStep;

  // dimensions
  late double stepCirclePadding;
  late double circleStepNameSpacer;
  late double verticalPadding;
  late double horizontalPadding;

  VAEAStepper({
    super.key,
    required this.breakpoint,
    required this.layoutConstraints,
    required this.stepsNames,
    required this.currStep
  }) {
    setupDimensions();
  }


  /// It is a helper method for constructor. It initializes the dimensions fields.
  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      stepCirclePadding = layoutConstraints.maxHeight * 0.02;
      circleStepNameSpacer = layoutConstraints.maxHeight * 0.005;
      verticalPadding = layoutConstraints.maxHeight * 0.01;
      horizontalPadding = layoutConstraints.maxWidth * 0.05;
    } else if (breakpoint.device.name == "mediumHandset") {
      stepCirclePadding = layoutConstraints.maxHeight * 0.02;
      circleStepNameSpacer = layoutConstraints.maxHeight * 0.005;
      verticalPadding = layoutConstraints.maxHeight * 0.01;
      horizontalPadding = layoutConstraints.maxWidth * 0.05;
    } else {
      stepCirclePadding = layoutConstraints.maxHeight * 0.02;
      circleStepNameSpacer = layoutConstraints.maxHeight * 0.005;
      verticalPadding = layoutConstraints.maxHeight * 0.01;
      horizontalPadding = layoutConstraints.maxWidth * 0.05;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).colorScheme.outlineVariant, width: 2))
      ),
      width: layoutConstraints.maxWidth,
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      alignment: Alignment.center,
      child: EasyStepper(
        activeStep: currStep,
        finishedStepTextColor: Theme.of(context).colorScheme.outlineVariant,
        lineLength: (layoutConstraints.maxWidth - horizontalPadding) / stepsNames.length,
        lineSpace: 5000,
        lineType: LineType.normal,
        internalPadding: 0,
        showLoadingAnimation: false,
        stepRadius: 8,
        showStepBorder: false,
        showTitle: true,
        steps: buildSteps(context),
      ),
    );
  }


  /// It builds the list of steps that include the number, circle, and the name.
  List<EasyStep> buildSteps(BuildContext context) {
    List<EasyStep> steps = [];
    for (int i = 0; i < stepsNames.length; i++) {
      steps.add(buildNthStep(context, i));
    }

    return steps;
  }

  /// It is a helper method for buildSteps. It builds a single step.
  EasyStep buildNthStep(BuildContext context, int stepIndex) {
    return EasyStep(
      title: stepsNames[stepIndex],
      customStep: Container(
        padding: EdgeInsets.all(stepCirclePadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 4, color: (stepIndex <= currStep)
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline
          ),
          color: (stepIndex == currStep)
          ? Theme.of(context).colorScheme.primary
              : Colors.white
        ),
        child: Text(
          "${stepIndex + 1}",
          style: TextStyle(
            color: (stepIndex == currStep)
              ? Colors.white
              : Theme.of(context).colorScheme.outline
          ),
        ),
      )
    );
  }

}
