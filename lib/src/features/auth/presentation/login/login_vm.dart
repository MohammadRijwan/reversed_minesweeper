import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:revered_minesweeper/src/core/common/flutter_toast.dart';
import 'package:revered_minesweeper/src/features/auth/domain/interface/i_auth_repo.dart';
import 'package:revered_minesweeper/src/features/reversed_minesweeper/presentation/screens/game_screen.dart';

class LoginVm extends ChangeNotifier {
  final IAuthRepo authRepository;

  LoginVm({required this.authRepository}) : super();

  void onLogin(BuildContext context) async {
    final result = await authRepository.googleSignIn();
    result.fold((onLeft) {
      FlutterToast.show(message: '$onLeft');
    }, (onRight) {
      context.pushReplacementNamed(GameScreen.route);
    });
  }
}
