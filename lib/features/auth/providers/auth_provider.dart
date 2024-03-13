import 'package:approvelt/features/auth/screens/auth_checker_screen.dart';
import 'package:approvelt/features/auth/services/auth_service.dart';
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
    final credential = await AuthService.loginUser(email, password);
    credential.fold((e) async {
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
      state = false;
    }, (r) {
      state = false;
      Navigator.pushNamedAndRemoveUntil(
          context, AuthChecker.routeName, (route) => false);
    });
  }

  // SignUp the user using Email and Password
  Future<void> signUpWithEmailAndPassword(String email, String password,
      String name, String type, BuildContext context) async {
    state = true;
    final usercred =
        await AuthService.registerUser(email, password, name, type);
    usercred.fold((e) async {
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
                  ]));
      state = false;
    }, (r) {
      Navigator.pushNamedAndRemoveUntil(
          context, AuthChecker.routeName, (route) => false);
      state = false;
    });
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
