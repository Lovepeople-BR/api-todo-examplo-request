import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/controllers/home_controller.dart';
import 'package:todo_lovepeople/data/model/todo.dart';
import 'package:todo_lovepeople/data/todo_repository.dart';
import 'package:todo_lovepeople/data/user_repository.dart';
import 'package:todo_lovepeople/view/home_page.dart';

import '../../robot.dart';

class TodoRepositoryMock extends Mock implements TodoRepository {}

class UserRepositoryMock extends Mock implements UserRepository {}

class HomePageRobot extends Robot {
  late TodoRepository todoRepository;
  late UserRepository userRepository;
  HomePageRobot(super.tester) {
    todoRepository = TodoRepositoryMock();
    userRepository = UserRepositoryMock();
  }

  Future<void> configure() async {
    await _confMock();
    await widgetSetup(
      ChangeNotifierProvider(
        create: (_) => HomeController(todoRepository, userRepository),
        child: const HomePage(),
      ),
    );
    await awaitForAnimations();
  }

  Future<void> didTapRegister() async {
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
  }

  void assetCallRegisterPage() {
    assetNavigatorPush('/register-todo');
  }

  _confMock() {
    when(() => todoRepository.getList()).thenAnswer((_) {
      return Future.value([
        Todo(
            id: 12345,
            attributes: Attributes(
                color: '#FF0000',
                title: 'Teste todo',
                description: 'Todo description description')),
        Todo(
            id: 1234235,
            attributes: Attributes(
                color: '#2986cc',
                title: 'Teste todo',
                description: 'Todo description description')),
        Todo(
            id: 1234345,
            attributes: Attributes(
                color: '#8fce00',
                title: 'Teste todo',
                description: 'Todo description description')),
      ]);
    });
  }

  Future<void> assetSnapshotShowScreen() {
    return takeSnapshot('HomePage_show');
  }
}
