import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:easy_stepper/easy_stepper.dart';

import '../../data/enums/service_status_enum.dart';

/// It provides the UI representation for the service request status.
class ServiceStatusFormatter {

  /// It returns string representation for the given status
  static String mapEnumToText(BuildContext context, ServiceStatusEnum serviceStatus) {
    switch(serviceStatus) {
      case ServiceStatusEnum.pending:
        return AppLocalizations.of(context)!.pendingStatus;
      case ServiceStatusEnum.scheduled:
        return AppLocalizations.of(context)!.scheduledStatus;
      default: //case ServiceStatusEnum.concluded:
        return AppLocalizations.of(context)!.concludedStatus;
    }
  }

  /// It returns Color representation for the given status
  static Color mapEnumToColor(BuildContext context, ServiceStatusEnum serviceStatus) {
    switch(serviceStatus) {
      case ServiceStatusEnum.pending:
        return Theme.of(context).colorScheme.primary;
      case ServiceStatusEnum.scheduled:
        return Theme.of(context).colorScheme.secondary;
      default: //case ServiceStatusEnum.concluded:
        return Theme.of(context).colorScheme.tertiary;
    }
  }


  /// It returns a Chip Widget representation for the given status
  static Widget buildStatusChip(BuildContext context, ServiceStatusEnum serviceStatus) {
    Widget icon;
    switch (serviceStatus) {
      case ServiceStatusEnum.pending:
        icon = Icon(Icons.alarm, color: mapEnumToColor(context, serviceStatus), size: 15);
        break;
      case ServiceStatusEnum.scheduled:
        icon = Icon(Icons.alarm_on_outlined, color: mapEnumToColor(context, serviceStatus), size: 15,);
        break;
      case ServiceStatusEnum.concluded:
        icon = Icon(Icons.check, color: mapEnumToColor(context, serviceStatus), size: 15);
    }

    return Chip(
      backgroundColor: mapEnumToColor(context, serviceStatus),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(horizontal: 0.0, vertical: -2),
      label: Text(
        mapEnumToText(context, serviceStatus),
        style: TextStyle(fontSize: Theme.of(context).textTheme.labelSmall!.fontSize, color: Colors.white),
      ),
      padding: EdgeInsets.zero,
      avatar: CircleAvatar(
        maxRadius: 10,
        backgroundColor: Theme.of(context).colorScheme.background,
        child: icon,
      ),
    );

  }
}