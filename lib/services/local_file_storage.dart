import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/task.dart';

class LocalFileStorage {
  static const _fileName = 'tasks.json';

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final file = await _getFile();
    final jsonString = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await file.writeAsString(jsonString);
  }

  Future<List<Task>> loadTasks() async {
    try {
      final file = await _getFile();
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = jsonDecode(contents);
        return jsonList.map((json) => Task.fromJson(json)).toList();
      }
    } catch (e) {
      print('Error reading tasks file: $e');
    }
    return [];
  }
}
