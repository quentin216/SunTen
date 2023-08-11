import 'package:flutter/material.dart';
import 'package:sun_ten/custom_colors.dart';

class Button extends StatelessWidget {
  final String userInput;
  VoidCallback confirmation;
  Button({
    super.key,
    required this.userInput,
    required this.confirmation,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.only(left: 30, right: 30, top: 12, bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      onPressed: confirmation,
      color: stGreen,
      child: Text(userInput,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ); 
  }
}
