import 'package:approvelt/constants/utils.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool isObscure;
  final IconData icon;

  const CustomTextField({
    super.key,
    required this.name,
    required this.controller,
    required this.isObscure,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        TextUtil(
          text: name,
        ),
        Container(
          height: 35,
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))),
          child: TextFormField(
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Enter your $name';
              }
              return null;
            },
            controller: controller,
            obscureText: isObscure,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              errorStyle: const TextStyle(color: Colors.orange),
              suffixIcon: Icon(
                icon,
                color: Colors.white,
              ),
              fillColor: Colors.white,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
