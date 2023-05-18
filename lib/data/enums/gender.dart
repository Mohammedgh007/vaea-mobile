
/// It represents the names of two genders
enum Gender {
  male,
  female
}


/// It maps the backend data of gender to this enum.
extension GenderParser on Gender {
  /// It handles the parsing of Gender out of backend string
  static Gender parse(String genderStr) {
    if (genderStr == "MALE") {
      return Gender.male;
    } else {
      return Gender.female;
    }
  }
}


/// It is used to map enum values to backend string
extension GenderSerializer on Gender {
  /// It serializes the enum value into backend string
  static String serialize(Gender genderEnum) {
    if (genderEnum == Gender.male) {
      return "MALE";
    } else {
      return "FEMALE";
    }
  }
}