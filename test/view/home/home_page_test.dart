import 'package:flutter_test/flutter_test.dart';

import 'home_page_robot.dart';

void main() {
  testWidgets('Should show load screen with TODOs', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.assetSnapshotShowScreen();
  });

  testWidgets('Should show delete dialog', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.didTapDeleteFirstItem();
    await robot.awaitForAnimations();
    await robot.assetSnapshotShowDeleteDialog();
  });

  testWidgets('Should redirect do resgister TODO page', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.didTapRegister();
    await robot.awaitForAnimations();
    robot.assetCallRegisterPage();
  });

  testWidgets('Should logout', (tester) async {
    final robot = HomePageRobot(tester);
    await robot.configure();
    await robot.didTapExit();
    await robot.awaitForAnimations();
    robot.assetCallLogout();
    robot.assetCallLoginPage();
  });
}
