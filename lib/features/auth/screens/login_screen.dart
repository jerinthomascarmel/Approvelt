import 'dart:ui';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/constants/utils.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/auth/screens/register_screen.dart';
import 'package:approvelt/features/auth/widgets/custom_button.dart';
import 'package:approvelt/features/auth/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String routName = '/login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUser(String email, String password, BuildContext context) async {
    await ref
        .read(authenticationProvider.notifier)
        .signInWithEmailAndPassword(email, password, context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authenticationProvider);
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(gradient: orangeGradient),
              alignment: Alignment.center,
              child: Container(
                height: 400,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Center(
                                  child: TextUtil(
                                text: "Login",
                                weight: true,
                                size: 30,
                              )),
                              const Spacer(),
                              CustomTextField(
                                  name: "Email",
                                  controller: _emailController,
                                  isObscure: false,
                                  icon: Icons.email),
                              CustomTextField(
                                  name: "Password",
                                  controller: _passwordController,
                                  isObscure: true,
                                  icon: Icons.lock),
                              const Spacer(),
                              CustomButton(
                                text: 'Log In',
                                onTap: () {
                                  if (_loginFormKey.currentState!.validate()) {
                                    logInUser(_emailController.text,
                                        _passwordController.text, context);
                                  }
                                },
                              ),
                              const Spacer(),
                              Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextUtil(
                                    text: "Don't have a account ",
                                    size: 12,
                                    weight: true,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          RegisterScreen.routeName,
                                          (route) => false);
                                    },
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              248, 146, 209, 115)),
                                    ),
                                  )
                                ],
                              )),
                              const Spacer(),
                            ],
                          ),
                        ),
                      )),
                ),
              ),
            ),
          );
  }
}
