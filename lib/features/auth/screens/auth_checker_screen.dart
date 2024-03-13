import 'package:approvelt/common/bottom_bar.dart';
import 'package:approvelt/common/error_screen.dart';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthChecker extends ConsumerWidget {
  static const String routeName = "/authChecker";
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
        data: (data) {
          if (data != null) return const BottomBar();
          return const LoginScreen();
        },
        loading: () => const LoadingScreen(),
        error: (e, trace) => ErrorScreen(error: e.toString()));
  }
}
