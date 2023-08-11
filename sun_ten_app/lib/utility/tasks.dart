import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sun_ten/custom_colors.dart';
import 'package:hive/hive.dart';

class Task extends StatelessWidget {
  final String taskTitle;
  final bool isDone;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteButton;

  Task(
      {
      required this.taskTitle,
      required this.isDone,
      required this.onChanged,
      required this.deleteButton});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteButton,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(25),
              backgroundColor: Colors.red.shade400,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                value: isDone,
                onChanged: onChanged,
                activeColor: stButton,
              ),
              Expanded(
                child: Text(
                  taskTitle,
                  style: TextStyle(
                      fontSize: 17,
                      decoration: isDone ? TextDecoration.lineThrough : null),
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: stMenu,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
