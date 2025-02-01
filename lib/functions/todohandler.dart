import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:marie/todo.dart';

class ToDosModel extends ChangeNotifier {
  final List<Todo> _toDos = [];

  void getPrefs() async {
    _toDos.clear();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var listOfTodos = jsonDecode(prefs.getString('todos') ?? "[]") as List;
    for (int i = 0; i < listOfTodos.length; i++) {
      _toDos.add(Todo.fromJson(listOfTodos[i]));
    }
    notifyListeners();
  }

  void writePrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonToDos = [];
    for (int i = 0; i < _toDos.length; i++) {
      jsonToDos.add(_toDos[i].toJson());
    }
    await prefs.setString('todos', jsonEncode(jsonToDos));
  }

  void toggleToDo(Todo oldToDo, bool newState) {
    int index = _toDos.indexOf(oldToDo);
    _toDos[index].state = newState;
    writePrefs();
    notifyListeners();
  }

  void addNewTodo(Todo newToDo) {
    _toDos.add(newToDo);
    writePrefs();
    notifyListeners();
  }

  void removeToDo(Todo toRemoveToDo) {
    _toDos.remove(toRemoveToDo);
    writePrefs();
    notifyListeners();
  }

  void editToDo(oldToDo, newToDo) {
    var index = _toDos.indexOf(oldToDo);
    if (index > -1) {
      _toDos.remove(oldToDo);
      _toDos.insert(index, newToDo);
    } else {
      addNewTodo(newToDo);
    }
    writePrefs();
    notifyListeners();
  }

  UnmodifiableListView<Todo> get toDos => UnmodifiableListView(_toDos);
}
