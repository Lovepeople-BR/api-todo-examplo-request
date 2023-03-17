import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        var prefs = await SharedPreferences.getInstance();
        prefs.setString(UserRepository.KEY_TOKEN, value);
        success?.call();
      } else {
        failure?.call();
      }
    }).catchError((e) {
      failure?.call();
    });
  }

  void verifyLogin(VoidCallback logged) async {
    var prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(UserRepository.KEY_TOKEN);
    if (token != null && token.isNotEmpty) {
      logged();
    }
  }
}
