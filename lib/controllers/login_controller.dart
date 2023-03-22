import 'package:flutter/material.dart';
import 'package:todo_lovepeople/data/user_repository.dart';

class LoginController extends ChangeNotifier {
  final UserRepository userRepository;

  LoginController(this.userRepository);

  void login(
    String email,
    String senha, {
    VoidCallback? success,
    VoidCallback? failure,
  }) {
    userRepository.login(email, senha).then((value) async {
      if (value != null) {
        success?.call();
      } else {
        failure?.call();
      }
    }).catchError((e) {
      failure?.call();
    });
  }

  void verifyLogin(VoidCallback logged) async {
    bool isLogged = await userRepository.isLogged();
    if (isLogged) {
      logged();
    }
  }
}
