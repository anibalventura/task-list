import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:task_list/data/models/task_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TaskController with ChangeNotifier {
  List<Task> _items = [];
  List<Task> get items => [..._items];

  final Map<String, String> _headers = {
    'content-type': 'application/json; charset=utf-8',
  };

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

  Future<void> addTask(Task newTask) async {
    try {
      final responseData = await http.post(
        Uri.parse(dotenv.env['API_URL']!),
        headers: _headers,
        body: json.encode(newTask.toJson()),
      );

      final newItem = Task(
        // ignore: avoid_dynamic_calls
        id: json.decode(responseData.body)['id'],
        name: newTask.name,
        isComplete: newTask.isComplete,
      );

      _items.add(newItem);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editTask(Task editedTask, Task newTask) async {
    final taskIndex = _items.indexWhere((item) => item.id == editedTask.id);

    if (taskIndex >= 0) {
      try {
        await http.put(
          Uri.parse("${dotenv.env['API_URL']!}/${editedTask.id}"),
          headers: _headers,
          body: json.encode({
            'id': editedTask.id,
            'name': newTask.name,
            'isComplete': newTask.isComplete,
          }),
        );

        _items[taskIndex] = newTask;

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
        headers: _headers,
        body: json.encode({
          'id': task.id,
          'name': task.name,
          'isComplete': isComplete,
        }),
      );

      final taskIndex = _items.indexWhere((item) => item.id == task.id);
      _items[taskIndex].isComplete = isComplete;

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
