
/// It represents the four types of leases' periods 3,6, and 12 months
enum LeasePeriodEnum {
  months3,
  months6,
  months12
}


/// It maps the backend data of lease period to this enum.
extension LeasePeriodEnumParser on LeasePeriodEnum { // TODO
  /// It handles the parsing of lease period out of backend string
  static LeasePeriodEnum parse(String leasePeriodStr) {
    if (leasePeriodStr == "3 MONTHS") {
      return LeasePeriodEnum.months3;
    } else if (leasePeriodStr == "6 MONTHS") {
      return LeasePeriodEnum.months6;
    } else {
      return LeasePeriodEnum.months12;
    }
  }
}


/// It is used to map enum values to backend string
extension LeasePeriodEnumSerializer on LeasePeriodEnum {
  /// It serializes the enum value into backend string
  static String serialize(LeasePeriodEnum leasePeriod) {
    if (leasePeriod == LeasePeriodEnum.months3) {
      return "3 MONTHS";
    } else if (leasePeriod == LeasePeriodEnum.months6) {
      return "6 MONTHS";
    } else {
      return "12 MONTHS";
    }
  }
}