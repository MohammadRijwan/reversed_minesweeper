import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revered_minesweeper/splash_screen.dart';
import 'package:revered_minesweeper/src/features/reversed_minesweeper/presentation/screens/final_screen.dart';

import '../../features/auth/presentation/login/login_screen.dart';
import '../../features/reversed_minesweeper/presentation/screens/game_screen.dart';

class AppRoute {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      getAllRoutes(),
    ],
    errorBuilder: (BuildContext context, GoRouterState state) =>
        RouteErrorScreen(
            title: 'Route Not Found',
            message: 'Error! The route ${state.error} not found.'),
  );

  static GoRouter get router => _router;

  static GoRoute getAllRoutes() {
    return GoRoute(
        path: SplashScreen.route,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
        routes: <RouteBase>[
          getLoginRoute(),
          getGameRoute(),
          getFinalScreenRoute()
        ]);
  }

  static GoRoute getLoginRoute() {
    return GoRoute(
        path: LoginScreen.route,
        name: LoginScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen());
  }

  static GoRoute getGameRoute() {
    return GoRoute(
        path: GameScreen.route,
        name: GameScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            const GameScreen());
  }

  static GoRoute getFinalScreenRoute() {
    return GoRoute(
        path: FinalScreen.route,
        name: FinalScreen.route,
        builder: (BuildContext context, GoRouterState state) =>
            FinalScreen(discoveredBombs: state.extra as int));
  }
}

class RouteErrorScreen extends StatelessWidget {
  final String title;
  final String message;

  const RouteErrorScreen(
      {super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 30.0),
        ),
      ),
    );
  }
}
