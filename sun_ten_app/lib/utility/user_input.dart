import 'package:flutter/material.dart';
import 'package:sun_ten/utility/button.dart';
import 'package:sun_ten/custom_colors.dart';

class userInput extends StatelessWidget {
  final control;
  VoidCallback confirm;
  VoidCallback cancel;

  userInput(
      {super.key,
      required this.control,
      required this.confirm,
      required this.cancel,});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: stMenu,
      content: Container(
        height: 100,
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: control,
              decoration: InputDecoration(
                  hintText: "Add new task",
                  hintStyle: TextStyle(color: stGreen)
              ),
            ),

// Confirm to add new task
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(userInput: 'Confirm', confirmation: confirm),
                const SizedBox(
                  width: 10,
                ),
                Button(userInput: 'Cancel', confirmation: cancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
