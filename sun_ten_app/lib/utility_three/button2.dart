import 'package:flutter/material.dart';
import 'package:sun_ten/custom_colors.dart';

class Button2 extends StatelessWidget {
  final String userTouch;
  VoidCallback confirmation;
  Button2({
    super.key,
    required this.userTouch,
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
      child: Text(userTouch,
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    ); 
  }
}