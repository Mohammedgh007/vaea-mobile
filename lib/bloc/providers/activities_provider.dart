import 'package:flutter/material.dart';

import '../../data/repo/activities_repo.dart';

class ActivitiesProvider extends ChangeNotifier {
  loadMonthEvents() async {
    var serviceRepo = ActivitiesRepo();
    // var response = await serviceRepo.loadActivities();
  }
}
