import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/taskcard.dart';

class TaskList extends ChangeNotifier {
  static Map<int, Map> taskList = {};

  List<int> upcomingTask = [];
  List<int> completedTask = [];

  Map get totalList => taskList;

  void add(List data) {
    taskList.addEntries([
      MapEntry(totalList.length, {
        'title': data[0],
        'colorScheme': data[1],
        'date': data[2],
        'time': data[3],
      })
    ]);
    upcomingTask.add(totalList.length - 1);
    notifyListeners();
  }

  void taskChecked(int x) {
    completedTask.add(x);
    upcomingTask.remove(x);
    notifyListeners();
  }

  void taskUnchecked(int x) {
    completedTask.remove(x);
    upcomingTask.add(x);
    notifyListeners();
  }
}
