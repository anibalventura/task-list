import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:task_list/models/task_model.dart';

class TaskController with ChangeNotifier {
  List<Task> _items = [];
  List<Task> get items => [..._items];

  final Map<String, String> _headers = {
    'content-type': 'application/json; charset=utf-8',
  };

  Future<void> getTasks() async {
    try {
      final response = await http.get(
        Uri.parse(
          Platform.isAndroid
              ? dotenv.env['AVD_API_URL']!
              : dotenv.env['API_URL']!,
        ),
      );
      final responseData = json.decode(response.body) as List;
      _items = responseData
          .map(
            (dynamic json) => Task.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addTask(Task newTask) async {
    try {
      final responseData = await http.post(
        Uri.parse(
          Platform.isAndroid
              ? dotenv.env['AVD_API_URL']!
              : dotenv.env['API_URL']!,
        ),
        headers: _headers,
        body: json.encode(newTask.toJson()),
      );

      final newItem = Task(
        // ignore: avoid_dynamic_calls
        id: json.decode(responseData.body)['id'] as int,
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
          Uri.parse(
            Platform.isAndroid
                ? "${dotenv.env['AVD_API_URL']!}/${editedTask.id}"
                : "${dotenv.env['API_URL']!}/${editedTask.id}",
          ),
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

  // ignore: avoid_positional_boolean_parameters
  Future<void> toggleIsComplete(Task task, bool isComplete) async {
    try {
      await http.put(
        Uri.parse(
          Platform.isAndroid
              ? "${dotenv.env['AVD_API_URL']!}/${task.id}"
              : "${dotenv.env['API_URL']!}/${task.id}",
        ),
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

    final response = await http.delete(
      Uri.parse(
        Platform.isAndroid
            ? "${dotenv.env['AVD_API_URL']!}/$id"
            : "${dotenv.env['API_URL']!}/$id",
      ),
    );

    if (response.statusCode >= 400) {
      _items.insert(existingItemIndex, existingItem);
      notifyListeners();
      throw Exception();
    }

    existingItem = null;
  }
}
