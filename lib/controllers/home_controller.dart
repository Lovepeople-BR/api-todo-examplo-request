import 'package:flutter/material.dart';
import 'package:todo_lovepeople/data/model/todo.dart';
import 'package:todo_lovepeople/data/todo_repository.dart';
import 'package:todo_lovepeople/data/user_repository.dart';

class HomeController extends ChangeNotifier {
  final TodoRepository todoRepository;
  final UserRepository userRepository;

  List<Todo> todoList = [];

  HomeController(this.todoRepository, this.userRepository);

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
    return userRepository.logout();
  }
}
