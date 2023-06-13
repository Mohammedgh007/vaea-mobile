
/// It represents the room type for submitting a service.
enum RoomNameEnum {
  kitchen,
  bathroom,
  bedroom,
  livingRoom,
  other
}


/// It maps the backend data to this enum.
extension RoomNameEnumParser on RoomNameEnum {
  /// It handles the parsing the backend string
  static RoomNameEnum parse(String roomNameStr) {
    switch(roomNameStr) {
      case "KITCHEN":
        return RoomNameEnum.kitchen;
      case "BATHROOM":
        return RoomNameEnum.bathroom;
      case "BEDROOM":
        return RoomNameEnum.bedroom;
      case "LIVINGROOM":
        return RoomNameEnum.livingRoom;
      default: // "OTHER"
        return RoomNameEnum.other;
    }
  }
}


/// It is used to map enum values to backend string
extension RoomNameEnumSerializer on RoomNameEnum {
  /// It serializes the enum value into backend string
  static String serialize(RoomNameEnum roomName) {
    switch (roomName) {
      case RoomNameEnum.kitchen:
        return "KITCHEN";
      case RoomNameEnum.bathroom:
        return "BATHROOM";
      case RoomNameEnum.bedroom:
        return "BEDROOM";
      case RoomNameEnum.livingRoom:
        return "LIVINGROOM";
      default: // case RoomNameEnum.other:
        return "OTHER";
    }
  }
}
