import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:revered_minesweeper/src/features/auth/data/auth_repo.dart';
import 'package:revered_minesweeper/src/features/auth/domain/interface/i_auth_repo.dart';
import 'package:revered_minesweeper/src/features/auth/domain/interface/i_db.dart';
import 'package:revered_minesweeper/src/features/auth/domain/remote_datasource/firebase_db.dart';
import 'package:revered_minesweeper/src/features/auth/presentation/login/login_vm.dart';

final firebaseDbProvider = Provider.autoDispose<IDb>((ref) {
  return FirebaseDb();
});

final authRepositoryProvider = Provider.autoDispose<IAuthRepo>(
    (ref) => AuthRepo(database: ref.read(firebaseDbProvider)));

final loginVmProvider = ChangeNotifierProvider<LoginVm>((ref) {
  return LoginVm(
    authRepository: ref.read(authRepositoryProvider),
  );
});
