
/// It represents the service type such as cleaning.
enum ServiceTypeEnum {
  cleaning,
  plumber,
  electrician
}


/// It maps the backend data to this enum.
extension ServiceTypeEnumParser on ServiceTypeEnum {
  /// It handles the parsing the backend string
  static ServiceTypeEnum parse(String serviceTypeStr) {
    switch(serviceTypeStr) {
      case "CLEANING":
        return ServiceTypeEnum.cleaning;
      case "PLUMBING":
        return ServiceTypeEnum.plumber;
      default: // KHOBAR
        return ServiceTypeEnum.electrician;
    }
  }
}


/// It is used to map enum values to backend string
extension ServiceTypeEnumSerializer on ServiceTypeEnum {
  /// It serializes the enum value into backend string
  static String serialize(ServiceTypeEnum serviceType) {
    switch (serviceType) {
      case ServiceTypeEnum.cleaning:
        return "CLEANING";
        break;
      case ServiceTypeEnum.plumber:
        return "PLUMBING";
        break;
      default: // ServiceType.electrician:
        return "ELECTRICIAN";
    }
  }
}