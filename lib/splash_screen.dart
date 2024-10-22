import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revered_minesweeper/src/core/common/spinkit_widget.dart';
import 'package:revered_minesweeper/src/features/auth/presentation/login/login_screen.dart';
import 'package:revered_minesweeper/src/features/reversed_minesweeper/presentation/screens/game_screen.dart';

class SplashScreen extends StatefulWidget {
  static String route = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    load();
    super.initState();
  }

  load() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await Future.delayed(const Duration(seconds: 1));
    if (auth.currentUser != null) {
      context.pushReplacementNamed(GameScreen.route);
    } else {
      context.pushReplacementNamed(LoginScreen.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Welcome to Reversed Minesweeper',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          const SpinKitWidget(),
        ],
      ),
    );
  }
}
