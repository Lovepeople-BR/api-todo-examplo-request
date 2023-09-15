import 'dart:ui';

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

const apiUrl = 'https://todo.rafaelbarbosatec.com/api/';
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
          create: (context) => HomeController(context.read(), context.read()),
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

class TestBlur extends StatelessWidget {
  const TestBlur({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Image.network(
                  'https://e0.pxfuel.com/wallpapers/738/89/desktop-wallpaper-simple-minimalistic-best-phone-background-no-distractions-scenery-painting-nature-simple-sunset.jpg'),
              Image.network(
                  'https://e0.pxfuel.com/wallpapers/738/89/desktop-wallpaper-simple-minimalistic-best-phone-background-no-distractions-scenery-painting-nature-simple-sunset.jpg'),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: CusomBottomNavigationBackground(),
          )
        ],
      ),
    );
  }
}

class CusomBottomNavigationBackground extends StatelessWidget {
  final double arcRadius;
  final double borderRadius;
  final double height;
  const CusomBottomNavigationBackground({
    super.key,
    this.arcRadius = 50,
    this.borderRadius = 10,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: EdgeInsets.only(top: arcRadius * 0.5),
          child: ClipPath(
            clipper: MyCustomClipper(
              arcRadius: arcRadius,
              borderRadius: borderRadius,
            ),
            child: SizedBox(
              height: height + MediaQuery.of(context).padding.bottom,
              width: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: CustomPaint(
                  painter: BNBCustomPainter(
                    arcRadius: arcRadius,
                    borderRadius: borderRadius,
                  ),
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: arcRadius * 1.4,
          height: arcRadius * 1.4,
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(
              arcRadius,
            ),
          ),
        )
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  final double arcRadius;
  final double borderRadius;

  BNBCustomPainter({this.arcRadius = 50, this.borderRadius = 10});
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Offset.zero & size;

    Paint paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.5),
          Colors.white.withOpacity(0.4),
          Colors.white.withOpacity(0.5),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.fill;

    Path path = CusomBottomNavigationPathBuilder(
      arcRadius,
      borderRadius,
    ).build(size);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BNBCustomPainter oldDelegate) {
    return arcRadius != oldDelegate.arcRadius ||
        borderRadius != oldDelegate.borderRadius;
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  final double arcRadius;
  final double borderRadius;

  MyCustomClipper({this.arcRadius = 50, this.borderRadius = 10});
  @override
  Path getClip(Size size) {
    return CusomBottomNavigationPathBuilder(
      arcRadius,
      borderRadius,
    ).build(size);
  }

  @override
  bool shouldReclip(covariant MyCustomClipper oldClipper) {
    return arcRadius != oldClipper.arcRadius ||
        borderRadius != oldClipper.borderRadius;
  }
}

class CusomBottomNavigationPathBuilder {
  final double arcRadius;
  final double borderRadius;

  CusomBottomNavigationPathBuilder(this.arcRadius, this.borderRadius);

  Path build(Size size) {
    Path path = Path();

    double midX = size.width / 2;
    path.lineTo(midX - arcRadius, 0);
    path.quadraticBezierTo(
      midX - arcRadius + borderRadius,
      0,
      midX - arcRadius + borderRadius,
      borderRadius,
    );

    path.arcToPoint(
      Offset(midX + arcRadius - borderRadius, borderRadius),
      radius: Radius.circular(arcRadius / 2),
      clockwise: false,
    );

    path.quadraticBezierTo(
      midX + arcRadius - borderRadius,
      0,
      midX + arcRadius,
      0,
    );
    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    return path;
  }
}
