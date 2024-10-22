import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:revered_minesweeper/src/features/auth/domain/providers/auth_provider.dart';
import 'package:revered_minesweeper/src/features/auth/presentation/login/login_screen.dart';
import 'package:revered_minesweeper/src/features/reversed_minesweeper/presentation/widgets/game_board.dart';

import '../../domain/providers/game_provider.dart';

class GameScreen extends ConsumerWidget {
  static String route = 'game_screen';
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reversed Minesweeper'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('No')),
                        TextButton(
                            onPressed: () {
                              ref.read(authRepositoryProvider).logout();
                              ref.invalidate(gameProvider);
                              context.pushReplacementNamed(LoginScreen.route);
                            },
                            child: const Text('Yes')),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: GameBoard(game: game),
    );
  }
}
