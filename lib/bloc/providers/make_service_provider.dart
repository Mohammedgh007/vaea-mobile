import 'dart:convert';

import 'package:flutter/material.dart';

import '../../data/enums/issue_category.dart';
import '../../data/enums/rooms_enum.dart';
import '../../data/repo/make_service_request_repo.dart';

class MakeServicesProvider extends ChangeNotifier {
  RoomType? _selectedRoom = RoomType.BATHROOM;
  IssueCategory? _selectedCategory = IssueCategory.BATHROOM_SINK;
  DateTime? _selectedDate = DateTime.now();
  bool _isMakingRequest = false; // to track the request status

  RoomType? get selectedRoom => _selectedRoom;
  IssueCategory? get selectedCategory => _selectedCategory;
  DateTime? get selectedDate => _selectedDate;
  bool get isMakingRequest => _isMakingRequest;

  void setSelectedRoom(RoomType? room) {
    _selectedRoom = room;
    notifyListeners();
  }

  void setSelectedCategory(IssueCategory? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSelectedDate(DateTime? date) {
    _selectedDate = date;
    notifyListeners();
  }

  Future makeRequest(supURl,
      {required String description, String? notes}) async {
    _isMakingRequest = true;
    notifyListeners();

    var serviceRepo = ServiceRepo();
    var request = await serviceRepo.makeRequest(
      supUrl: supURl,
      preferedDate: selectedDate.toString(),
      category: selectedCategory!.name,
      room: selectedRoom!.name,
      description: description,
      notes: notes,
    );
    _isMakingRequest = false;
    notifyListeners();
    return (request);
  }
}
