import 'package:hive_flutter/hive_flutter.dart';
import '../utility_three/notes.dart';

class NoteDataBase{
  final _container2 = Hive.box('note container');
  List notes = [];
  List filteredNotes = [];

// Default data
  void initial() {
    notes = [];
    filteredNotes = [];
  }

// Keep data
  void keep() {
    notes = _container2.get("NOTELIST");
    filteredNotes = notes;
  }

// Update data
  void update() {
    _container2.put("NOTELIST", notes);
  }
}
