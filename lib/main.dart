import 'package:approvelt/common/error_screen.dart';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/constants/theme.dart';
import 'package:approvelt/features/auth/providers/firebase_init_provider.dart';
import 'package:approvelt/features/auth/screens/auth_checker_screen.dart';
import 'package:approvelt/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.lightTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      home: initialize.when(
          data: (data) {
            return const AuthChecker();
          },
          error: ((error, stackTrace) => ErrorScreen(error: error.toString())),
          loading: () => const LoadingScreen()),
    );
  }
}
