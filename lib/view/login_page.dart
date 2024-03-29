import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  // ignore:  constant_identifier_names
  static const KEY_BUTTON_LOGIN = Key('KEY_BUTTON_LOGIN');
  static const KEY_INPUT_EMAIL = Key('KEY_INPUT_EMAIL');
  static const KEY_INPUT_PASS = Key('KEY_INPUT_PASS');
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    context.read<LoginController>().verifyLogin(goHome);
    return Consumer<LoginController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 40),
                  ),
                  TextFormField(
                    key: LoginPage.KEY_INPUT_EMAIL,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      label: Text('E-mail'),
                    ),
                  ),
                  TextFormField(
                    key: LoginPage.KEY_INPUT_PASS,
                    controller: _senhaController,
                    decoration: const InputDecoration(
                      label: Text('Senha'),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      key: LoginPage.KEY_BUTTON_LOGIN,
                      onPressed: () {
                        controller.login(
                          _emailController.text,
                          _senhaController.text,
                          success: goHome,
                          failure: () {
                            print('Email ou senha inválidos');
                          },
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void goHome() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/home',
      (_) => false,
    );
  }
}
