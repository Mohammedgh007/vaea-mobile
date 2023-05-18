/// It represents the floor number including the ground and the roof
enum FloorEnum {
  ground,
  roof,
  first,
  second,
  third,
  forth
}


/// It maps the backend data of floor to this enum.
extension FloorEnumParser on FloorEnum {
  /// It handles the parsing of floor number out of backend string
  static FloorEnum parse(int floorStr) {
    switch (floorStr) {
      case -1:
        return FloorEnum.roof;
      case 0:
        return FloorEnum.ground;
      case 1:
        return FloorEnum.first;
      case 2:
        return FloorEnum.second;
      case 3:
        return FloorEnum.third;
      default: //case 4:
        return FloorEnum.forth;
    }
  }
}

/// It is used to map enum values to backend string
extension FloorEnumSerializer on FloorEnum {
  /// It serializes the enum value into backend string
  static int serialize(FloorEnum floorEnum) {
    switch (floorEnum) {
      case FloorEnum.roof:
        return -1;
      case FloorEnum.ground:
        return 0;
      case FloorEnum.first:
        return 1;
      case FloorEnum.second:
        return 2;
      case FloorEnum.third:
        return 3;
      default : //case FloorEnum.forth:
        return 4;
    }
  }
}