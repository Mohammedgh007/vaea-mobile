import 'dart:convert';

import 'package:breakpoint/breakpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../bloc/providers/make_service_provider.dart';
import '../../bloc/validators/sign_up_validator.dart';
import '../../data/enums/issue_category.dart';
import '../../data/enums/rooms_enum.dart';
import '../../data/enums/services_enums.dart';
import '../../routes_mapper.dart';
import '../widgets/buttons/primary_button.dart';
import '../widgets/fields/dropdown_field.dart';
import '../widgets/fields/text_field.dart';

class MakeServiceRequest extends StatefulWidget {
  const MakeServiceRequest({Key? key}) : super(key: key);

  @override
  State<MakeServiceRequest> createState() => _MakeServiceRequestState();
}

class _MakeServiceRequestState extends State<MakeServiceRequest> {
  late ServicesTypes servicesTypes;
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
    final ServicesTypes? args =
        ModalRoute.of(context)!.settings.arguments as ServicesTypes?;
    if (args != null) {
      servicesTypes = args;
    }
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

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Provider.of<MakeServicesProvider>(context, listen: false)
              .selectedDate ??
          DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      Provider.of<MakeServicesProvider>(context, listen: false)
          .setSelectedDate(picked);
    }
  }

  String mapTypeToTitle(BuildContext context) {
    switch(servicesTypes) {
      case ServicesTypes.houseCleaning:
        return AppLocalizations.of(context)!.houseCleaning;
      case ServicesTypes.plumbing:
        return AppLocalizations.of(context)!.plumbing;
      default: //case ServicesTypes.electrician:
        return AppLocalizations.of(context)!.electrician;

    }
  }

  String mapTypeToDisc(BuildContext context) {
    switch(servicesTypes) {
      case ServicesTypes.houseCleaning:
        return AppLocalizations.of(context)!.houseCleaningDisc;
      case ServicesTypes.plumbing:
        return AppLocalizations.of(context)!.plumbingDisc;
      default: //case ServicesTypes.electrician:
        return AppLocalizations.of(context)!.electricianDisc;

    }
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
              title: Text(mapTypeToTitle(context)),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    servicesTypes.image,
                    width: MediaQuery.of(context).size.width,
                    height: 254.h,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(mapTypeToDisc(context)),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.045.sw, vertical: 5.h),
                        child: Text(
                          AppLocalizations.of(context)!.preferredDayOfVisit,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(
                          context); // call the _selectDate function when the text is tapped
                    },
                    child: Container(
                      width: sectionContainerWidth,
                      height: 55.h,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline,
                              width: (layoutConstraints.maxWidth * 0.01) * 0.5),
                          borderRadius: BorderRadius.circular(
                              sectionContainerWidth * 0.04)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            provider.selectedDate == null
                                ? 'Select the date'
                                : 'Selected Date: ${provider.selectedDate!.day}/${provider.selectedDate!.month}/${provider.selectedDate!.year}',
                          ),
                          const Icon(Icons.calendar_month)
                        ],
                      ),
                    ),
                  ),
                  if (servicesTypes != ServicesTypes.houseCleaning)
                    Column(
                      children: [
                        SizedBox(
                          height: 13.h,
                        ),
                        VAEADropdownField<RoomType>(
                            breakpoint: breakpoint,
                            layoutConstraints: layoutConstraints,
                            handleChange: (RoomType? selected) {
                              provider.setSelectedRoom(selected);
                            },
                            options:
                                RoomType.values.map((e) => e.name).toList(),
                            optionsValues: RoomType.values,
                            currValue: (provider.selectedRoom != null)
                                ? provider.selectedRoom
                                : RoomType.KITCHEN,
                            labelStr: AppLocalizations.of(context)!.roomType,
                            hintStr: null),
                        SizedBox(
                          height: 13.h,
                        ),
                        VAEADropdownField<IssueCategory>(
                            breakpoint: breakpoint,
                            layoutConstraints: layoutConstraints,
                            handleChange: (IssueCategory? selected) {
                              provider.setSelectedCategory(selected);
                            },
                            options: IssueCategory.values
                                .map((e) => e.name)
                                .toList(),
                            optionsValues: IssueCategory.values,
                            currValue: (provider.selectedCategory != null)
                                ? provider.selectedCategory
                                : IssueCategory.BATHROOM_SHOWER,
                            labelStr:
                                AppLocalizations.of(context)!.issueCategoryLabel,
                            hintStr: null),
                        SizedBox(
                          height: 13.h,
                        ),
                        VAEATextField(
                          breakpoint: breakpoint,
                          layoutConstraints: layoutConstraints,
                          controller: discriptionController,
                          labelStr: AppLocalizations.of(context)!
                              .issueDescriptionLabel,
                          hintStr: AppLocalizations.of(context)!
                              .issueDescriptionHint,
                          textInputAction: TextInputAction.next,
                          isTextObscure: false,
                          errorMsg: disErrorMsg,
                          handleOnSubmitted: (String? input) async {
                            setState(() {
                              disErrorMsg = validateValues(input);
                            });
                          },
                        ),
                      ],
                    ),
                  SizedBox(
                    height: 13.h,
                  ),
                  VAEATextField(
                    breakpoint: breakpoint,
                    layoutConstraints: layoutConstraints,
                    controller: notesController,
                    labelStr: AppLocalizations.of(context)!.notesOptionalLabel,
                    hintStr: AppLocalizations.of(context)!.notesOptionalHint,
                    textInputAction: TextInputAction.next,
                    isTextObscure: false,
                    errorMsg: null,
                    handleOnSubmitted: (String? input) async {},
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  PrimaryBtn(
                    breakpoint: breakpoint,
                    layoutConstraints: layoutConstraints,
                    handleClick: () async {
                      if (!provider.isMakingRequest) {
                        var request = await provider.makeRequest(
                            servicesTypes.supURL,
                            description: discriptionController.text);
                        print(request['data']['request_id']);
                        if (request['status'] != null) {
                          Navigator.of(context).pushNamed(
                            RoutesMapper.getScreenRoute(
                              ScreenName.addNewServiceSuccess,
                            ),
                            arguments: {
                              'request_id':
                                  (request['data']['request_id']).toString(),
                              'title': servicesTypes.name,
                            },
                          );
                        }
                      }
                    },
                    buttonText: AppLocalizations.of(context)!.submitRequest,
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
