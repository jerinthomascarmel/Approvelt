import 'dart:ui';
import 'package:approvelt/constants/utils.dart';
import 'package:approvelt/features/auth/screens/register_screen.dart';
import 'package:approvelt/features/auth/widgets/custom_button.dart';
import 'package:approvelt/features/auth/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

enum Type { user, admin }

class LoginScreen extends StatefulWidget {
  static const String routName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginFormKey = GlobalKey<FormState>();
  Type _type = Type.user;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logInUser() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.black,
            Colors.orange,
          ],
        )),
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
                              logInUser();
                            }
                          },
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Row(
                                children: [
                                  Radio<Type>(
                                    fillColor:
                                        MaterialStateProperty.all(Colors.black),
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 14),
                              child: Row(
                                children: [
                                  Radio<Type>(
                                    fillColor:
                                        MaterialStateProperty.all(Colors.black),
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
                                Navigator.pushNamed(
                                    context, RegisterScreen.routeName);
                              },
                              child: const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(248, 146, 209, 115)),
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