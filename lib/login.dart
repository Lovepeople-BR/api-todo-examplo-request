import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_lovepeople/data/todo_repository.dart';
import 'package:todo_lovepeople/data/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  UserRepository userRepository = UserRepository();
  TodoRepository todoRepository = TodoRepository();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: login,
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: obterTodos,
              child: const Text('Obter TODOs'),
            ),
            ElevatedButton(
              onPressed: cadastrarTodo,
              child: const Text('Cadastrar TODO'),
            ),
            ElevatedButton(
              onPressed: deletarTodo,
              child: const Text('Deletar TODO'),
            ),
            ElevatedButton(
              onPressed: registrarUser,
              child: const Text('Registar Usuário'),
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    userRepository.login('lucas@email.com', '654321').then(
      (value) async {
        final prefs = await SharedPreferences.getInstance();
        print(value);
        if (value != null) {
          prefs.setString('token', value);
        }
      },
    );
  }

  void obterTodos() {
    todoRepository.getList().then((list) {
      print(list);
      for (var todo in list) {
        var att = todo.attributes!;
        print('Id: ${todo.id} / Title: ${att.title}');
      }
    });
  }

  void cadastrarTodo() {
    todoRepository
        .registerTodo(
      'Teste 45',
      'teste aula 32312312',
      '#D41243',
      
    )
        .then((value) {
      print(value);
    });
  }

  void deletarTodo() {
    todoRepository.delete('3').then((value) {
      print(value);
    });
  }

  void registrarUser() {
    userRepository.register('Lucas', 'lucas@email.com', '654321').then(
      (value) {
        print(value);
      },
    );
  }
}
