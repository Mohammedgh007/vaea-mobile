
/// It represents the set of issues related to the plumbing.
enum PlumbingIssueCategoryEnum {
  sink,
  washer,
  toilet,
  shower,
  other,
}


/// It maps the backend data to this enum.
extension PlumbingIssueCategoryEnumParser on PlumbingIssueCategoryEnum {
  /// It handles the parsing the backend string
  static PlumbingIssueCategoryEnum parse(String categoryStr) {
    switch(categoryStr) {
      case "SINK":
        return PlumbingIssueCategoryEnum.sink;
      case "WASHER":
        return PlumbingIssueCategoryEnum.washer;
      case "TOILET":
        return PlumbingIssueCategoryEnum.toilet;
      case "SHOWER":
        return PlumbingIssueCategoryEnum.shower;
      default: // "OTHER"
        return PlumbingIssueCategoryEnum.other;
    }
  }
}


/// It is used to map enum values to backend string
extension PlumbingIssueCategoryEnumSerializer on PlumbingIssueCategoryEnum {
  /// It serializes the enum value into backend string
  static String serialize(PlumbingIssueCategoryEnum category) {
    switch (category) {
      case PlumbingIssueCategoryEnum.sink:
        return "SINK";
      case PlumbingIssueCategoryEnum.washer:
        return "WASHER";
      case PlumbingIssueCategoryEnum.toilet:
        return "TOILET";
      case PlumbingIssueCategoryEnum.shower:
        return "SHOWER";
      default: // case PlumbingIssueCategoryEnum.other:
        return "OTHER";
    }
  }
}