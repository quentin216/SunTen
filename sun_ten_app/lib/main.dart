// Task Manager App for Sun Ten Laboratories
// Quentin Chen

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sun_ten/custom_colors.dart';
import 'package:sun_ten/task_page.dart';
import 'package:sun_ten/timer_page.dart';
import 'package:sun_ten/notes_page.dart';

void main() async {
// Hive to store tasks on app refresh
  await Hive.initFlutter();
  var container = await Hive.openBox('task container');
  var container2 = await Hive.openBox('note container');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPage = 0;
  List<Widget> appPages = const [
    TaskPage(),
    TimerPage(),
    NotesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode current = FocusScope.of(context);
        if (current.focusedChild != null && !current.hasPrimaryFocus) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        // App Bar with SunTen Logo

        home: Scaffold(
          backgroundColor: stPage,
          appBar: AppBar(
            title: Image.asset(
              'logo/sunten.jpg',
              height: 70,
              fit: BoxFit.contain,
            ),
            centerTitle: true,
            backgroundColor: stGreen,
            elevation: 10,
          ),
          body: IndexedStack(
            index: selectedPage,
            children: appPages,
          ),

          // Navigation Bar

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            iconSize: 30,
            selectedFontSize: 17,
            unselectedFontSize: 15,
            currentIndex: selectedPage,
            onTap: (index) {
              setState(
                () {
                  selectedPage = index;
                },
              );
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.check_box,
                  color: stPage,
                ),
                label: 'Tasks',
                backgroundColor: stRed,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.timer,
                  color: stPage,
                ),
                label: 'Timer',
                backgroundColor: stOrange,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.create,
                  color: stPage,
                ),
                label: 'Notes',
                backgroundColor: stButton,
              ),
            ],
          ),
        ),
      ),
    );
  }
} // end of class
