import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sun_ten/custom_colors.dart';
import 'package:hive/hive.dart';

class Note extends StatelessWidget {
  final String noteTitle;
  Function(BuildContext)? deleteButton2;

  Note(
      {
      required this.noteTitle,
      required this.deleteButton2});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteButton2,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(25),
              backgroundColor: Colors.red.shade400,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(33.7),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  noteTitle,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        decoration: BoxDecoration(
          color: Colors.yellow.shade200,
          borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}