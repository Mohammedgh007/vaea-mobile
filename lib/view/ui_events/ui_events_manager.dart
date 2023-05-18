
import 'package:event_bus/event_bus.dart';

import 'closing_search_panel_event.dart';

/// This class encapsulates all the events that was triggered by the ui. It includes
/// methods for listening and firing an event. This is a singleton class.
/// It uses EventBus to handle listening and firing the events.
class UiEventsManager {

  late EventBus eventBus;

  /* Ensuring singleton */
  static final UiEventsManager _instance = UiEventsManager._();
  factory UiEventsManager() {
    return _instance;
  }
  /* Ensuring singleton */

  UiEventsManager._() {
    eventBus = EventBus();
  }


  /// It listens to the event of ClosingSearchPanelEvent that is triggered by
  /// closing the search panel.
  void listenToClosingSearchPanelEvent(void Function(ClosingSearchPanelEvent event) handler) {
    eventBus.on<ClosingSearchPanelEvent>().listen(handler);
  }

  /// It fires ClosingSearchPanelEvent.
  void fireClosingSearchPanelEvent(ClosingSearchPanelEvent event) {
    eventBus.fire(event);
  }


}