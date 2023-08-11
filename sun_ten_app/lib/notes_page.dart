import 'package:flutter/material.dart';
import 'package:sun_ten/custom_colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../utility_three/button2.dart';
import '../utility_three/notes.dart';
import '../utility_three/button2.dart';
import '../utility_three/user_input2.dart';
import 'note_database/note_data.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
// Hive container
  final _container2 = Hive.box('task container');
  NoteDataBase data2 = NoteDataBase();

  int counter = 0;

  @override
  void initState() {
    if (_container2.get("NOTELIST") == null) {
      data2.initial();
    } else {
      data2.keep();
    }
    data2.filteredNotes = data2.notes;
    super.initState();
  }

  // Text control
  final controller2 = TextEditingController();

  // Search for specific tasks in the search bar
  void _noteFilter(String keyWord2) {
    List result2 = [];
    if (keyWord2.isEmpty) {
      result2 = data2.notes;
    } else {
      result2 = data2.notes
          .where((Note) =>
              Note[0].toString().toLowerCase().contains(keyWord2.toLowerCase()))
          .toList();
    }
    setState(() {
      data2.filteredNotes = result2;
    });
  }

  // confirm the addition of a new task
  void addNewNote() {
    setState(() {
      data2.notes.add([controller2.text, false]);
      controller2.clear();
    });
    Navigator.of(context).pop();
    data2.update();
    setState(() {});
  } // end of method

  // delete tasks
  void trash2(int index) {
    setState(() {
      data2.notes.removeAt(index);
    });
    data2.update();
  } // end of method

  // Add new tasks
  void typeNote() {
    showDialog(
      context: context,
      builder: (context) {
        // Textbox for typing new task
        return userInput2(
          control2: controller2,
          confirm2: addNewNote,
          cancel2: () => Navigator.of(context).pop(),
        );
      },
    );
  } // end of method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Your Notes",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          backgroundColor: stButton),
      backgroundColor: Colors.grey.shade300,
      floatingActionButton: FloatingActionButton(
        onPressed: typeNote,
        child: Icon(Icons.add),
        backgroundColor: stGreen,
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        )),
      ),
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
                    onChanged: (value) => _noteFilter(value),
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
                      hintText: "Search for note",
                      hintStyle: TextStyle(fontSize: 15, color: stGreen),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data2.filteredNotes.length,
              itemBuilder: (context, index) {
                return Note(
                  noteTitle: data2.filteredNotes[index][0],
                  deleteButton2: (p0) => trash2(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
