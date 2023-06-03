/// It represents the names of cities that are supported in the app.
enum IssueCategory {
  KITCHEN_SINK,
  KITCHEN_WASHER,
  BATHROOM_SINK,
  BATHROOM_TOILET,
  BATHROOM_SHOWER,
  OTHER_OTHER
}

/// It maps the backend data of issue category to this enum.
extension CategoryNameParser on IssueCategory {
  /// It handles the parsing of IssueCategory out of backend string
  static IssueCategory parse(String categoryStr) {
    switch (categoryStr) {
      case "KITCHEN_SINK":
        return IssueCategory.KITCHEN_SINK;
      case "KITCHEN_WASHER":
        return IssueCategory.KITCHEN_WASHER;
      case "BATHROOM_SINK":
        return IssueCategory.BATHROOM_SINK;
      case "BATHROOM_TOILET":
        return IssueCategory.BATHROOM_TOILET;
      case "BATHROOM_SHOWER":
        return IssueCategory.BATHROOM_SHOWER;
      case "OTHER_OTHER":
        return IssueCategory.OTHER_OTHER;
      default:
        throw ArgumentError('Unknown category: $categoryStr');
    }
  }
}

/// It is used to map enum values to backend string
extension CategoryNameSerializer on IssueCategory {
  /// It serializes the enum value into backend string
  String serialize() {
    switch (this) {
      case IssueCategory.KITCHEN_SINK:
        return "KITCHEN_SINK";
      case IssueCategory.KITCHEN_WASHER:
        return "KITCHEN_WASHER";
      case IssueCategory.BATHROOM_SINK:
        return "BATHROOM_SINK";
      case IssueCategory.BATHROOM_TOILET:
        return "BATHROOM_TOILET";
      case IssueCategory.BATHROOM_SHOWER:
        return "BATHROOM_SHOWER";
      case IssueCategory.OTHER_OTHER:
        return "OTHER_OTHER";
      default:
        throw ArgumentError('Unknown category: $this');
    }
  }
}
