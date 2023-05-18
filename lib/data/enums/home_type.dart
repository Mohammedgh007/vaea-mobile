
/// It represents the two types of home that are private and shared
enum HomeType {
  private,
  shared
}


/// It maps the backend data of home type to this enum.
extension HomeTypeParser on HomeType {
  /// It handles the parsing of home type out of backend string
  static HomeType parse(String homeTypeStr) {
    if (homeTypeStr == "PRIVATE") {
      return HomeType.private;
    } else {
      return HomeType.shared;
    }
  }
}


/// It is used to map enum values to backend string
extension HomeTypeSerializer on HomeType {
  /// It serializes the enum value into backend string
  static String serialize(HomeType homeType) {
    if (homeType == HomeType.private) {
      return "PRIVATE";
    } else {
      return "SHARED";
    }
  }
}