import 'package:flutter/material.dart';
import 'package:sun_ten/utility/button.dart';
import 'package:sun_ten/custom_colors.dart';

class userInput2 extends StatelessWidget {
  final control2;
  VoidCallback confirm2;
  VoidCallback cancel2;

  userInput2(
      {super.key,
      required this.control2,
      required this.confirm2,
      required this.cancel2,});

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
              controller: control2,
              decoration: InputDecoration(
                  hintText: "Add new note",
                  hintStyle: TextStyle(color: stGreen)
              ),
            ),

// Confirm to add new task
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(userInput: 'Confirm', confirmation: confirm2),
                const SizedBox(
                  width: 10,
                ),
                Button(userInput: 'Cancel', confirmation: cancel2),
              ],
            )
          ],
        ),
      ),
    );
  }
}