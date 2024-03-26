import 'package:approvelt/features/auth/screens/auth_checker_screen.dart';
import 'package:approvelt/features/auth/services/auth_service.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userModelProvider = StateProvider<UserModel>((ref) => UserModel(
    uid: '', email: '', password: '', name: '', type: 'user', uidPhotoUrl: ''));

final authenticationProvider =
    StateNotifierProvider<Authentication, bool>((ref) {
  return Authentication(false, ref);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authenticationProvider.notifier).authStateChange;
});

final getUserModelStreamProvider = StreamProvider<UserModel>((ref) =>
    ref.read(authenticationProvider.notifier).getCurrentUserModelStream);

class Authentication extends StateNotifier<bool> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Ref ref;

  Authentication(super.state, this.ref);
  Stream<User?> get authStateChange => _auth.authStateChanges();
  Stream<UserModel> get getCurrentUserModelStream =>
      AuthService.getCurrentUserModelStream();

  //update current user
  void updateCurrentUser() {
    var userStream = AuthService.getCurrentUserModelStream();
    userStream.listen((UserModel userModel) {
      ref.read(userModelProvider.notifier).update((state) => userModel);
    });
  }

  //sigin User
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
