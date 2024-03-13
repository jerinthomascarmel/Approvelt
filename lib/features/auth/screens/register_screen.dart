import 'dart:ui';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/constants/utils.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/auth/screens/login_screen.dart';
import 'package:approvelt/features/auth/widgets/custom_button.dart';
import 'package:approvelt/features/auth/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Type { user, admin }

class RegisterScreen extends ConsumerStatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  Type _type = Type.user;
  final _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void registerUser(String email, String password, String name, Type type,
      BuildContext context) async {
    String typeToString = (type == Type.admin) ? "admin" : "user";
    await ref.read(authenticationProvider.notifier).signUpWithEmailAndPassword(
        email, password, name, typeToString, context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = ref.watch(authenticationProvider);
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
                          key: _registerFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              Center(
                                  child: TextUtil(
                                text: "Register",
                                weight: true,
                                size: 30,
                              )),
                              const Spacer(),
                              CustomTextField(
                                name: "Username",
                                controller: _usernameController,
                                isObscure: false,
                                icon: Icons.person,
                              ),
                              CustomTextField(
                                  name: "Email",
                                  controller: _emailController,
                                  isObscure: false,
                                  icon: Icons.email),
                              const Spacer(),
                              CustomTextField(
                                  name: "Password",
                                  controller: _passwordController,
                                  isObscure: true,
                                  icon: Icons.lock),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: Row(
                                      children: [
                                        Radio<Type>(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.black),
                                          value: Type.user,
                                          groupValue: _type,
                                          onChanged: (value) {
                                            setState(() {
                                              _type = value!;
                                            });
                                          },
                                        ),
                                        TextUtil(text: "User")
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14),
                                    child: Row(
                                      children: [
                                        Radio<Type>(
                                          fillColor: MaterialStateProperty.all(
                                              Colors.black),
                                          value: Type.admin,
                                          groupValue: _type,
                                          onChanged: (value) {
                                            setState(() {
                                              _type = value!;
                                            });
                                          },
                                        ),
                                        TextUtil(text: "Admin")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              CustomButton(
                                text: 'Register',
                                onTap: () {
                                  if (_registerFormKey.currentState!
                                      .validate()) {
                                    registerUser(
                                        _emailController.text,
                                        _passwordController.text,
                                        _usernameController.text,
                                        _type,
                                        context);
                                  }
                                },
                              ),
                              Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextUtil(
                                    text: "Already have an account ",
                                    size: 12,
                                    weight: true,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        LoginScreen.routName,
                                        (route) => false,
                                      );
                                    },
                                    child: const Text(
                                      'Login',
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
