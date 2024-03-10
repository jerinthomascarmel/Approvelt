import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authenticationProvider =
    StateNotifierProvider<Authentication, bool>((ref) {
  return Authentication(false);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider.notifier).authStateChange;
});

class Authentication extends StateNotifier<bool> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Authentication(super.state);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    state = true;
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      state = false;
    } on FirebaseAuthException catch (e) {
      state = false;
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Error Occured'),
          content: Text(e.toString()),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"))
          ],
        ),
      );
    }
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    state = true;
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      state = false;
    } on FirebaseAuthException catch (e) {
      state = false;
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                  title: Text('Error Occured'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text("OK"))
                  ]));
    } catch (e) {
      if (e == 'email-already-in-use') {
        print('Email already in use.');
      } else {
        print('Error: $e');
      }
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
