import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sun_ten/custom_colors.dart';

import '../utility/button.dart';
import '../utility/tasks.dart';
import '../utility/button.dart';
import '../utility/user_input.dart';
import 'task_database/task_data.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
// Hive container
  final _container = Hive.box('task container');
  TaskDataBase data = TaskDataBase();

  @override
  void initState() {
    if (_container.get("TASKLIST") == null) {
      data.initial();
    } else {
      data.keep();
    }
    data.filteredTasks = data.tasks;
    super.initState();
  }

// Text control
  final controller = TextEditingController();

// Search for specific tasks in the search bar
  void _taskFilter(String keyWord) {
    List result = [];
    if (keyWord.isEmpty) {
      result = data.tasks;
    } else {
      result = data.tasks
          .where((Task) =>
              Task[0].toString().toLowerCase().contains(keyWord.toLowerCase()))
          .toList();
    }
    setState(() {
      data.filteredTasks = result;
    });
  }

// Marks task as complete with checkmark
  void checkmark(bool? value, int index) {
    setState(() {
      data.tasks[index][1] = !data.tasks[index][1];
    });
    data.update();
  } // end of method

  // confirm the addition of a new task
  void addNewTask() {
    setState(() {
      data.tasks.add([controller.text, false]);
      controller.clear();
    });
    Navigator.of(context).pop();
    data.update();
    setState(() {});
  } // end of method

  // delete tasks
  void trash(int index) {
    setState(() {
      data.tasks.removeAt(index);
    });
    data.update();
  } // end of method

  // Add new tasks
  void typeTask() {
    showDialog(
      context: context,
      builder: (context) {
        // Textbox for typing new task
        return userInput(
          control: controller,
          confirm: addNewTask,
          cancel: () => Navigator.of(context).pop(),
        );
      },
    );
  } // end of method

  @override
  //builds the scaffolding
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Today's Tasks",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: stRed,
      ),
      backgroundColor: Colors.grey.shade300,

// Add new tasks to the list
      floatingActionButton: FloatingActionButton(
        onPressed: typeTask,
        child: Icon(Icons.add),
        backgroundColor: stGreen,
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),

// Builds the task list
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    onChanged: (value) => _taskFilter(value),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      prefixIcon: Icon(
                        Icons.search,
                        color: stGreen,
                        size: 20,
                      ),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        minWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: 'Search for task',
                      hintStyle: TextStyle(fontSize: 15, color: stGreen),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.filteredTasks.length,
              itemBuilder: (context, index) {
                return Task(
                  taskTitle: data.filteredTasks[index][0],
                  isDone: data.filteredTasks[index][1],
                  onChanged: (value) => checkmark(value, index),
                  deleteButton: (p0) => trash(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
