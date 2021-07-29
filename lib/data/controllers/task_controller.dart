import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_list/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TaskController with ChangeNotifier {
  List<Task> _items = [];
  List<Task> get items => [..._items];

  Future<void> getTasks() async {
    try {
      final response = await http.get(
        Uri.parse(dotenv.env['API_URL']!),
      );
      final responseData = json.decode(response.body) as List;

      _items = responseData.map((json) => Task.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTask(Task task) async {
    try {
      final responseData = await http.post(
        Uri.parse(dotenv.env['API_URL']!),
        headers: {'content-type': 'application/json; charset=utf-8'},
        body: json.encode(task.toJson()),
      );

      final newItem = Task(
        // ignore: avoid_dynamic_calls
        id: json.decode(responseData.body)['id'],
        name: task.name,
        isComplete: task.isComplete,
      );

      _items.add(newItem);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editTask(Task editedTask, Task newTask) async {
    final itemIndex = _items.indexWhere((item) => item.id == editedTask.id);

    if (itemIndex >= 0) {
      try {
        await http.put(
          Uri.parse("${dotenv.env['API_URL']!}/${editedTask.id}"),
          headers: {'content-type': 'application/json; charset=utf-8'},
          body: json.encode({
            'id': editedTask.id,
            'name': newTask.name,
            'isComplete': newTask.isComplete,
          }),
        );

        _items[itemIndex] = newTask;

        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> toggleIsComplete(Task task, bool isComplete) async {
    try {
      await http.put(
        Uri.parse("${dotenv.env['API_URL']!}/${task.id}"),
        headers: {'content-type': 'application/json; charset=utf-8'},
        body: json.encode({
          'id': task.id,
          'name': task.name,
          'isComplete': isComplete,
        }),
      );

      final itemIndex = _items.indexWhere((item) => item.id == task.id);
      _items[itemIndex].isComplete = isComplete;

      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(int id) async {
    final existingItemIndex = _items.indexWhere((item) => item.id == id);
    Task? existingItem = _items[existingItemIndex];

    _items.removeAt(existingItemIndex);
    notifyListeners();

    final response =
        await http.delete(Uri.parse("${dotenv.env['API_URL']!}/$id"));

    if (response.statusCode >= 400) {
      _items.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw Exception();
    }

    existingItem = null;
  }
}
