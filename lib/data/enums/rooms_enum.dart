enum RoomType { KITCHEN, BATHROOM, OTHER }

extension RoomNameParser on String {
  RoomType toRoomType() {
    switch (this) {
      case "KITCHEN":
        return RoomType.KITCHEN;
      case "BATHROOM":
        return RoomType.BATHROOM;
      case "OTHER":
        return RoomType.OTHER;
      default:
        throw ArgumentError('Unknown RoomType: $this');
    }
  }
}

extension RoomNameSerializer on RoomType {
  String toShortString() {
    switch (this) {
      case RoomType.KITCHEN:
        return "KITCHEN";
      case RoomType.BATHROOM:
        return "BATHROOM";
      case RoomType.OTHER:
        return "OTHER";
      default:
        throw ArgumentError('Unknown RoomType: $this');
    }
  }
}
