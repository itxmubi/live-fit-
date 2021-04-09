import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthBase {
  User get currentUser;
  Future<User> signInWithFacebook();
  Stream<User> authstateschanges();
  Future<User> signInAnnonimously();
  Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseauth = FirebaseAuth.instance;

  @override
  Stream<User> authstateschanges() => _firebaseauth.authStateChanges();

  @override
  User get currentUser => _firebaseauth.currentUser;

  @override
  Future<User> signInAnnonimously() async {
    final userCredential = await _firebaseauth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseauth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final usercredential = await _firebaseauth.signInWithCredential(
            FacebookAuthProvider.credential(accessToken.token));
        return usercredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
            message: "Aborted by user", code: "Aborted by user code");
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
            message: "Aborted by Error", code: "Aborted by Error code");
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async {
    //   final googleSingIn = GoogleSignIn();
    //await googleSingIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseauth.signOut();
  }
}
