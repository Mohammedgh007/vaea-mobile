import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/providers/make_service_provider.dart';
import '../../bloc/validators/sign_up_validator.dart';
import '../../routes_mapper.dart';
import '../style/colors.dart';
import '../widgets/buttons/primary_button.dart';

class AddNewServiceSuccess extends StatefulWidget {
  const AddNewServiceSuccess({Key? key}) : super(key: key);

  @override
  State<AddNewServiceSuccess> createState() => _AddNewServiceSuccessState();
}

class _AddNewServiceSuccessState extends State<AddNewServiceSuccess> {
  late TextEditingController discriptionController;
  late TextEditingController notesController;
  late Breakpoint breakpoint;
  late BoxConstraints layoutConstraints;
  late double sectionsSpacer;
  late double sectionContainerWidth;
  late double sectionContainerPadding;
  late double containerRowsSpacer;

  late double imageSize;
  late double horizontalPadding;
  late double mapViewHeight;
  late double titleSpacer;
  late double bodyTextSpacer;
  late String requestId;
  late String title;
  String? disErrorMsg;

  void setupDimensions() {
    if (breakpoint.device.name == "smallHandset") {
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      sectionContainerWidth = layoutConstraints.maxWidth * 0.92;
      sectionContainerPadding = layoutConstraints.maxWidth * 0.04;
      containerRowsSpacer = layoutConstraints.maxHeight * 0.01;

      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else if (breakpoint.device.name == "mediumHandset") {
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      sectionContainerWidth = layoutConstraints.maxWidth * 0.92;
      sectionContainerPadding = layoutConstraints.maxWidth * 0.04;
      containerRowsSpacer = layoutConstraints.maxHeight * 0.01;

      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    } else {
      sectionsSpacer = layoutConstraints.maxHeight * 0.03;
      sectionContainerWidth = layoutConstraints.maxWidth * 0.92;
      sectionContainerPadding = layoutConstraints.maxWidth * 0.04;
      containerRowsSpacer = layoutConstraints.maxHeight * 0.01;

      imageSize = layoutConstraints.maxWidth;
      horizontalPadding = layoutConstraints.maxWidth * 0.03;
      mapViewHeight = layoutConstraints.maxHeight * 0.28;
      titleSpacer = layoutConstraints.maxHeight * 0.012;
      bodyTextSpacer = layoutConstraints.maxHeight * 0.004;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    requestId = arguments['request_id'];
    title = arguments['title'];
  }

  @override
  void initState() {
    super.initState();

    discriptionController = TextEditingController();
    notesController = TextEditingController();
  }

  @override
  void dispose() {
    discriptionController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MakeServicesProvider(),
      child: Consumer<MakeServicesProvider>(
        builder: (context, provider, child) => LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          breakpoint = Breakpoint.fromConstraints(constraints);
          layoutConstraints = constraints;
          setupDimensions();
          return Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 92.h,
                  ),
                  Image.asset(
                    'assets/images/done.png',
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Order #$requestId has been submitted successfully',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'A VAEA agent would contact you soon via email to schedule an appointment',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontFamily: 'Montserrat'),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 68.h,
                  ),
                  PrimaryBtn(
                    breakpoint: breakpoint,
                    layoutConstraints: layoutConstraints,
                    handleClick: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        RoutesMapper.getScreenRoute(ScreenName.services),
                        (Route<dynamic> route) => false,
                      );

                      // Navigator.of(context).popUntil(ModalRoute.withName(
                      //   RoutesMapper.getScreenRoute(
                      //     ScreenName.services,
                      //   ),
                      // ));
                    },
                    buttonText: AppLocalizations.of(context)!.finish,
                    width: sectionContainerWidth,
                    // disabled: provider
                    //     .isMakingRequest, // disable the button when making a request
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  String? validateValues(String? input) {
    if (input == null || input.replaceAll(" ", "").isEmpty) {
      return AppLocalizations.of(context)!.requiredFieldErrorMsg;
    } else if (!SignUpValidator.namesRegExp.hasMatch(input)) {
      return AppLocalizations.of(context)!.invalidNameErrorMsg;
    } else {
      return null;
    }
  }
}
