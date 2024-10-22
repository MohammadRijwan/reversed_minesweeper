import 'package:fpdart/fpdart.dart';

abstract class IAuthRepo {
  Future<Either<Exception, String>> googleSignIn();

  Future<void> logout();
}
