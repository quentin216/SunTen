import 'package:flutter/material.dart';
import 'package:sun_ten/custom_colors.dart';

class TimerButton extends StatelessWidget {
  final String text;
  final VoidCallback tapped;

  const TimerButton({
    Key? key,
    required this.text,
    required this.tapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: tapped, 
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.all(17),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
      ),
      backgroundColor: stGreen,
    ),
    child: Text(
      text, 
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
       ),
      ),
    );
  }
}
