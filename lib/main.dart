import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/controllers/home_controller.dart';
import 'package:todo_lovepeople/controllers/login_controller.dart';
import 'package:todo_lovepeople/controllers/register_todo_controller.dart';
import 'package:todo_lovepeople/data/todo_repository.dart';
import 'package:todo_lovepeople/data/user_repository.dart';
import 'package:todo_lovepeople/view/home_page.dart';
import 'package:todo_lovepeople/view/login_page.dart';
import 'package:todo_lovepeople/view/register_todo_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepository>(create: (_) => UserRepository()),
        Provider<TodoRepository>(create: (_) => TodoRepository()),
        ChangeNotifierProvider(
          create: (context) => LoginController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeController(context.read()),
        ),
        ChangeNotifierProvider(
          create: (context) => RegisterTodoController(context.read()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (_) => const LoginPage(),
          '/home': (_) => const HomePage(),
          '/register-todo': (_) => const RegisterTodoPage(),
        },
      ),
    );
  }
}
