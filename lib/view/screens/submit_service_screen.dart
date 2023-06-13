import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaea_mobile/bloc/validators/submit_service_validator.dart';
import 'package:vaea_mobile/data/dto/house_cleaning_dto.dart';
import 'package:vaea_mobile/data/dto/plumbing_dto.dart';
import 'package:vaea_mobile/data/enums/electrician_issue_category_enum.dart';
import 'package:vaea_mobile/helpers/excpetions/expired_token_except.dart';
import 'package:vaea_mobile/helpers/excpetions/internet_connection_except.dart';
import 'package:vaea_mobile/routes_mapper.dart';
import 'package:vaea_mobile/view/layouts/mobile/submit_service_layout.dart';
import 'package:vaea_mobile/view/widgets/alerts/no_internet_alert.dart';

import '../../bloc/providers/services_provider.dart';
import '../../data/dto/electrician_dto.dart';
import '../../data/enums/plumbing_issue_category_enum.dart';
import '../../data/enums/room_name_eunm.dart';

/// This class handles the view and its interactions with the rest of app
/// for submitting service request screen.
class SubmitRequestScreen extends StatefulWidget {

  const SubmitRequestScreen({super.key});

  @override
  State<SubmitRequestScreen> createState() => _SubmitRequestScreenState();
}

class _SubmitRequestScreenState extends State<SubmitRequestScreen> {

  late final ServicesProvider servicesProvider;
  late final SubmitServiceValidator validator;

  @override
  void initState() {
    super.initState();

    servicesProvider = Provider.of<ServicesProvider>(context, listen: false);
    validator = SubmitServiceValidator(context: context);
  }

  @override
  Widget build(BuildContext context) {

    return SubmitServiceLayout(
      handleSubmitCleaningService: handleSubmitHouseCleaningRequest,
      handleSubmitPlumbingService: handleSubmitPlumbingRequest,
      handleSubmitElectricianService: handleSubmitElectricianRequest,
      handleClickFinish: handleClickFinish,
      validatePreferredDate: validator.validateDropdownField,
      validateDropdownField: validator.validateDropdownField,
      validateDescription: validator.validateDescription,
      validateNotes: validator.validateNotes,
    );
  }


  /// It handles submitting the house cleaning request.
  Future<int> handleSubmitHouseCleaningRequest({ required DateTime preferredDate, required String? notes }) async {
      try {
        HouseCleaningDto requestDTO = HouseCleaningDto(preferredAppointmentDate: preferredDate, notes: notes);
        return servicesProvider.submitCleaningService(requestDTO);
      } on InternetConnectionException catch(e) {
        showDialog(context: context, builder: (_) => NoInternetAlert(okHandler: () {}));
        return -1;
      }
  }


  /// It handles submitting the plumbing request.
  Future<int> handleSubmitPlumbingRequest({
    required DateTime preferredDate,
    required RoomNameEnum selectedRoom,
    required PlumbingIssueCategoryEnum selectedCategory,
    required String description,
    required String? notes
  }) async {
    try {
      PlumbingDto requestDTO = PlumbingDto(
        preferredAppointmentDate: preferredDate,
        selectedRoom: selectedRoom,
        selectedCategory: selectedCategory,
        description: description,
        notes: notes
      );
      return servicesProvider.submitPlumbingService(requestDTO);
    } on InternetConnectionException catch(e) {
      showDialog(context: context, builder: (_) => NoInternetAlert(okHandler: () {}));
      return -1;
    }
  }


  /// It handles submitting the electrician request.
  Future<int> handleSubmitElectricianRequest({
    required DateTime preferredDate,
    required RoomNameEnum selectedRoom,
    required ElectricianIssueCategoryEnum selectedCategory,
    required String description,
    required String? notes
  }) async {
    try {
      ElectricianDto requestDTO = ElectricianDto(
          preferredAppointmentDate: preferredDate,
          selectedRoom: selectedRoom,
          selectedCategory: selectedCategory,
          description: description,
          notes: notes
      );
      return servicesProvider.submitElectricianService(requestDTO);
    } on InternetConnectionException catch(e) {
      showDialog(context: context, builder: (_) => NoInternetAlert(okHandler: () {}));
      return -1;
    }
  }


  /// It takes the user back to the services screen.
  void handleClickFinish() {
    Navigator.of(context).pushReplacementNamed(RoutesMapper.getScreenRoute(ScreenName.services));
  }

}