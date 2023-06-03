import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../data/repo/activities_repo.dart';

class EventDataSource extends CalendarDataSource {
  EventDataSource(List<Event> source) {
    appointments = source;
  }
}

class ActivitiesProvider extends ChangeNotifier {
  EventResponse? serviceResponse;

  loadMonthEvents(String month) async {
    var serviceRepo = ActivitiesRepo();
    var response = await serviceRepo.loadActivities(month);
    serviceResponse = EventResponse.fromJson(response);
    notifyListeners();
  }

  List<Event> get appointments {
    if (serviceResponse == null) {
      return [];
    } else {
      return serviceResponse!.data;
    }
  }
}

class Event extends Appointment {
  final int eventId;
  final String eventName;
  final String groupImageUrl;
  final int goingPeople;

  Event({
    required this.eventId,
    required this.eventName,
    required this.groupImageUrl,
    required DateTime startTime,
    required DateTime endTime,
    required this.goingPeople,
  }) : super(
            startTime: startTime,
            endTime: endTime,
            subject: eventName,
            notes: groupImageUrl,
            location: eventId.toString());

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['event_id'] as int,
      eventName: json['event_name'] as String,
      groupImageUrl: json['group_image_url'] as String,
      startTime: DateTime.parse(json['date_time'] as String),
      endTime:
          DateTime.parse(json['date_time'] as String).add(Duration(hours: 1)),
      goingPeople: json['going_people'] as int,
    );
  }
}

class EventResponse {
  final int status;
  final List<Event> data;

  EventResponse({
    required this.status,
    required this.data,
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Event> eventData =
        dataList.map((i) => Event.fromJson(i as Map<String, dynamic>)).toList();

    return EventResponse(
      status: json['status'] as int,
      data: eventData,
    );
  }
}
