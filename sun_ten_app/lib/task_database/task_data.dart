import 'package:hive_flutter/hive_flutter.dart';
import '../utility/tasks.dart';

class TaskDataBase {
  final _container = Hive.box('task container');
  List tasks = [];
  List filteredTasks = [];

// Default data
  void initial() {
    tasks = [];
    filteredTasks = [];
  }

// Keep data
  void keep() {
    tasks = _container.get("TASKLIST");
    filteredTasks = tasks;
  }

// Update data
  void update() {
    _container.put("TASKLIST", tasks);
  }
}
