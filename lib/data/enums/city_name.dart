
/// It represents the names of cities that are supported in the app.
enum CityName {
  riyadh,
  jeddah,
  khobar
}


/// It maps the backend data of city name to this enum.
extension CityNameParser on CityName {
  /// It handles the parsing of CityName out of backend string
  static CityName parse(String cityStr) {
    switch(cityStr) {
      case "RIYADH":
        return CityName.riyadh;
      case "JEDDAH":
        return CityName.jeddah;
      default: // KHOBAR
        return CityName.khobar;
    }
  }
}


/// It is used to map enum values to backend string
extension CityNameSerializer on CityName {
  /// It serializes the enum value into backend string
  static String serialize(CityName city) {
    switch (city) {
      case CityName.riyadh:
        return "RIYADH";
        break;
      case CityName.jeddah:
        return "JEDDAH";
        break;
      default: // CityName.khobar:
        return "KHOBAR";
    }
  }
}