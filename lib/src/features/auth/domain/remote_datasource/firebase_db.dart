import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:revered_minesweeper/src/features/auth/domain/interface/i_db.dart';

class FirebaseDb implements IDb {
  @override
  Future<Either<Exception, String>> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      log('Logged in :${FirebaseAuth.instance.currentUser}');
      return const Right('Success');
    } catch (e) {
      log('Exception:::: ${e}');
      return Left(
          Exception('Something went wrong please try again later. ${e}'));
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    log('Logged out :${FirebaseAuth.instance.currentUser}');
  }
}
