
/// It represents the set of issues related to the electrician.
enum ElectricianIssueCategoryEnum {
  outlet,
  lamp,
  fanSuction,
  other
}


/// It maps the backend data to this enum.
extension ElectricianIssueCategoryEnumParser on ElectricianIssueCategoryEnum {
  /// It handles the parsing the backend string
  static ElectricianIssueCategoryEnum parse(String categoryStr) {
    switch(categoryStr) {
      case "OUTLET":
        return ElectricianIssueCategoryEnum.outlet;
      case "LAMP":
        return ElectricianIssueCategoryEnum.lamp;
      case "FAN_SUCTION":
        return ElectricianIssueCategoryEnum.fanSuction;
      default: // "OTHER"
        return ElectricianIssueCategoryEnum.other;
    }
  }
}


/// It is used to map enum values to backend string
extension ElectricianIssueCategoryEnumSerializer on ElectricianIssueCategoryEnum {
  /// It serializes the enum value into backend string
  static String serialize(ElectricianIssueCategoryEnum category) {
    switch (category) {
      case ElectricianIssueCategoryEnum.outlet:
        return "OUTLET";
      case ElectricianIssueCategoryEnum.lamp:
        return "LAMP";
      case ElectricianIssueCategoryEnum.fanSuction:
        return "FAN_SUCTION";
      default: // case PlumbingIssueCategoryEnum.other:
        return "OTHER";
    }
  }
}