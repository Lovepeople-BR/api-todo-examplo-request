import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:todo_lovepeople/controllers/login_controller.dart';
import 'package:todo_lovepeople/data/user_repository.dart';
import 'package:todo_lovepeople/view/login_page.dart';

import '../../robot.dart';

class UserRepositoryMock extends Mock implements UserRepository {}

class LoginPageRobot extends Robot {
  late UserRepository _repository;
  LoginPageRobot(super.tester) {
    _repository = UserRepositoryMock();
  }

  Future<void> configure({bool isLogged = false}) async {
    await _confMock(isLogged: isLogged);
    await widgetSetup(
      ChangeNotifierProvider(
        create: (context) => LoginController(_repository),
        child: const LoginPage(),
      ),
    );
  }

  _confMock({bool isLogged = false}) {
    when(() => _repository.isLogged()).thenAnswer((invocation) {
      return Future.value(isLogged);
    });

    when(() => _repository.login(any(), any())).thenAnswer((invocation) {
      return Future.value('token');
    });
  }

  Future<void> didEnterEmail(String email) async {
    await tester.enterText(find.byKey(LoginPage.KEY_INPUT_EMAIL), email);
    await tester.pumpAndSettle();
  }

  Future<void> didEnterPass(String pass) async {
    await tester.enterText(find.byKey(LoginPage.KEY_INPUT_PASS), pass);
    await tester.pumpAndSettle();
  }

  Future<void> didTapLoginButton() async {
    await tester.tap(find.byKey(LoginPage.KEY_BUTTON_LOGIN));
    await tester.pumpAndSettle();
  }

  void assetCallHome() {
    assetNavigatorPush('/home');
  }

  Future<void> assetSnapshotShowScreen() {
    return takeSnapshot('LoginPage_show');
  }
}
