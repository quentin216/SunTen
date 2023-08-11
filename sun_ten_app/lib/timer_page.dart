import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sun_ten/custom_colors.dart';
import 'package:sun_ten/main.dart';
import 'package:sun_ten/utility/button.dart';
import 'package:sun_ten/utility_two/timer_button.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int counter = 0;
  String timerInput = '';
  int userHours = 0;
  int userMin = 0;
  int userSec = 0;

  static const setSeconds = 59;
  int initialSec = 0;
  static const setMinutes = 59;
  int initialMin = 0;
  static const setHours = 0;
  int initialHour = 0;

  TextEditingController hrControl = TextEditingController();
  TextEditingController minControl = TextEditingController();
  TextEditingController secControl = TextEditingController();
  final int maxLength = 2;

  bool timerRunning = false;
  Timer? countdown;

  @override
  void initState() {
    super.initState();
    hrControl = TextEditingController();
    minControl = TextEditingController();
    secControl = TextEditingController();
  }

  void startCountdown() {
    if (timerRunning) {
      return;
    }
    setState(() {
      timerRunning = true;
    });
    countdown = Timer.periodic(Duration(seconds: 1), (_) {
      if (userSec >= 0 && hrControl.text.isNotEmpty ||
          minControl.text.isNotEmpty ||
          secControl.text.isNotEmpty) {
        setState(() {
          userSec--;
          if (userSec < 0 && userMin != 0) {
            userMin--;
            userSec = setSeconds;
          }
          if (userMin == 0 && userHours != 0 && userSec < 0) {
            userHours--;
            userMin = setMinutes;
            userSec = setSeconds;
          }
          if (userHours == 0 && userMin == 0 && userSec == 0) {
            final player = AudioCache();
            player.play('timer.mp3');
            stopCountDown();
            resetCountDown();
          }
        });
      } else {
        stopCountDown();
      }
    });
  }

  void stopCountDown() {
    countdown?.cancel();
    setState(() {
      timerRunning = false;
    });
  }

  void resetCountDown() {
    setState(() {
      timerRunning = false;
      userHours = initialHour;
      userMin = initialMin;
      userSec = initialSec;
      stopCountDown();
    });
    setState(() {
      hrControl.clear();
      minControl.clear();
      secControl.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Time Left",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: stOrange),
      backgroundColor: Colors.grey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: stButton,
            ),
            child: Center(
              child: createTimer(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: stButton,
                ),
                child: SizedBox(
                  width: 50,
                  child: TextField(
                    maxLength: maxLength,
                    controller: hrControl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          userHours = int.parse(text);
                        });
                      } else {
                        setState(() {
                          userHours = 0;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Hr',
                      labelStyle: TextStyle(fontSize: 15, color: stGreen),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: stButton,
                ),
                child: SizedBox(
                  width: 50,
                  child: TextField(
                    maxLength: maxLength,
                    controller: minControl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          userMin = int.parse(text);
                        });
                      } else {
                        setState(() {
                          userMin = 0;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Min',
                      labelStyle: TextStyle(fontSize: 15, color: stGreen),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: stButton,
                ),
                child: SizedBox(
                  width: 50,
                  child: TextField(
                    maxLength: maxLength,
                    controller: secControl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (text) {
                      if (text.isNotEmpty) {
                        setState(() {
                          userSec = int.parse(text);
                        });
                      } else {
                        setState(() {
                          userSec = 0;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      labelText: 'Sec',
                      labelStyle: TextStyle(fontSize: 15, color: stGreen),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createTimer() {
    return Column(
      children: [
        Text(
            '$userHours'.padLeft(2, '0') +
                ' : ' +
                '$userMin'.padLeft(2, '0') +
                ' : ' +
                '$userSec'.padLeft(2, '0'),
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.w500,
              color: stGreen,
            )),
      ],
    );
  }

  Widget createButton() {
    return Row(
      children: [
        TimerButton(
          text: 'Start',
          tapped: () {
            startCountdown();
          },
        ),
        const SizedBox(width: 10),
        TimerButton(
            text: 'Stop',
            tapped: () {
              stopCountDown();
            }),
        const SizedBox(width: 10),
        TimerButton(
            text: 'Reset',
            tapped: () {
              resetCountDown();
            }),
      ],
    );
  }
}
