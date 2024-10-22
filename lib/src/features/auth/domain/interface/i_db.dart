import 'package:fpdart/fpdart.dart';

abstract class IDb {
  Future<Either<Exception, String>> googleSignIn();

  Future<void> logout();
}
