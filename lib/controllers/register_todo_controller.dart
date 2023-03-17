import 'package:flutter/material.dart';
import 'package:todo_lovepeople/data/todo_repository.dart';

class RegisterTodoController extends ChangeNotifier {
  final TodoRepository todoRepository;

  String colorSelected = '';

  RegisterTodoController(this.todoRepository);

  void changeColor(String newColor) {
    colorSelected = newColor;
    notifyListeners();
  }

  void register(String title, String description, {VoidCallback? success}) {
    todoRepository
        .registerTodo(title, description, colorSelected)
        .then((created) {
      if (created) {
        success?.call();
      }
    });
  }
}
