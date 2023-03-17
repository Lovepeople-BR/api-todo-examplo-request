import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_lovepeople/data/model/todo.dart';
import 'package:todo_lovepeople/data/todo_repository.dart';
import 'package:todo_lovepeople/data/user_repository.dart';

class HomeController extends ChangeNotifier {
  final TodoRepository todoRepository;

  List<Todo> todoList = [];

  HomeController(this.todoRepository);

  void getTODOList() {
    todoRepository.getList().then((list) {
      todoList = list;
      notifyListeners();
    });
  }

  void delete(String id, {VoidCallback? success}) {
    todoRepository.delete(id).then((deleted) {
      if (deleted) {
        success?.call();
        getTODOList();
      }
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> logout() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.remove(UserRepository.KEY_TOKEN);
  }
}
