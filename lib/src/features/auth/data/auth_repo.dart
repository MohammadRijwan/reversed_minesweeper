import 'package:fpdart/fpdart.dart';
import 'package:revered_minesweeper/src/features/auth/domain/interface/i_auth_repo.dart';
import 'package:revered_minesweeper/src/features/auth/domain/interface/i_db.dart';

class AuthRepo implements IAuthRepo {
  final IDb _database;
  AuthRepo({required IDb database}) : _database = database;

  @override
  Future<Either<Exception, String>> googleSignIn() async {
    return await _database.googleSignIn();
  }

  //logout
  @override
  Future<void> logout() async {
    await _database.logout();
  }
}
