
/// It represents the districts for the frontend
enum DistrictEnum {
  aqiqRuh,
  malqaRuh
}

/// It maps the backend data of district name to this enum.
extension DistrictEnumParser on DistrictEnum {
  /// It handles the parsing of districtEnum out of backend string
  static DistrictEnum parse(String districtStr) {
    switch(districtStr) {
      case "AQIQ":
        return DistrictEnum.aqiqRuh;
      default: //case "MALQA":
        return DistrictEnum.malqaRuh;
    }
  }
}


/// It is used to map enum values to backend string
extension DistrictEnumSerializer on DistrictEnum {
  /// It serializes the enum value into backend string
  static String serialize(DistrictEnum district) {
    switch (district) {
      case DistrictEnum.aqiqRuh:
        return "AQIQ";
      default:
        return "MALQA";
    }
  }
}