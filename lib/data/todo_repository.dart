import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_lovepeople/data/model/todo.dart';
import 'package:todo_lovepeople/data/user_repository.dart';

class TodoRepository {
  String baseUrl = 'https://lovepeople-todo.onrender.com/api/';

  Future<List<Todo>> getList() async {
    final prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString(UserRepository.KEY_TOKEN);
    Uri uri = Uri.parse('${baseUrl}todos');
    return http.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      if (value.statusCode == 200) {
        Map json = jsonDecode(value.body);
        return (json['data'] as List).map((e) {
          return Todo.fromJson(e);
        }).toList();
      } else {
        return [];
      }
    });
  }

  Future<bool> registerTodo(
    String titulo,
    String descricao,
    String cor,
  ) async {
    Uri uri = Uri.parse('${baseUrl}todos');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(UserRepository.KEY_TOKEN);

    Map<String, dynamic> body = {
      'data': {
        "title": titulo,
        "description": descricao,
        "color": cor,
      }
    };
    return http
        .post(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(body),
    )
        .then((value) {
      if (value.statusCode == 200) {
        return true;
      }
      return false;
    });
  }

  Future<bool> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(UserRepository.KEY_TOKEN);

    Uri uri = Uri.parse('${baseUrl}todos/$id');

    return http.delete(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    ).then((value) {
      if (value.statusCode == 200) {
        return true;
      }
      return false;
    });
  }
}
