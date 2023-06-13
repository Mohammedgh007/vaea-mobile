
/// It represents the service status such as pending.
enum ServiceStatusEnum {
  pending,
  scheduled,
  concluded
}


/// It maps the backend data to this enum.
extension ServiceStatusEnumParser on ServiceStatusEnum {
  /// It handles the parsing the backend string
  static ServiceStatusEnum parse(String serviceStatusStr) {
    switch(serviceStatusStr) {
      case "PENDING":
        return ServiceStatusEnum.pending;
      case "SCHEDULED":
        return ServiceStatusEnum.scheduled;
      default: // CONCLUDED
        return ServiceStatusEnum.concluded;
    }
  }
}


/// It is used to map enum values to backend string
extension ServiceTypeStatusSerializer on ServiceStatusEnum {
  /// It serializes the enum value into backend string
  static String serialize(ServiceStatusEnum serviceType) {
    switch (serviceType) {
      case ServiceStatusEnum.pending:
        return "PENDING";
      case ServiceStatusEnum.scheduled:
        return "SCHEDULED";
      default: // ServiceStatusEnum.concluded:
        return "CONCLUDED";
    }
  }
}