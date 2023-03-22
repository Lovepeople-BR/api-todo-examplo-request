import 'package:flutter_test/flutter_test.dart';

import 'login_page_robot.dart';

void main() {
  testWidgets('Should show page', (tester) async {
    final robot = LoginPageRobot(tester);
    await robot.configure();
    await robot.assetSnapshotShowScreen();
  });

  testWidgets('Should do login with success', (tester) async {
    final robot = LoginPageRobot(tester);
    await robot.configure();
    await robot.didEnterEmail('email@email.com');
    await robot.didEnterPass('123456');
    await robot.didTapLoginButton();
    robot.assetCallHome();
  });
}
