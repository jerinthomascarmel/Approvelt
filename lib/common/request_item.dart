import 'dart:ffi';

import 'package:approvelt/constants/global_variable.dart';
import 'package:flutter/material.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // print("On Tapped " + task.id.toString());
        // _showBottomSheet(context, task);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), gradient: orangeGradient),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "jerin thomas",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Icon(Icons.arrow_forward)
                ],
              ),
              Divider(
                color: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "June 11,2022",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          // NOTE 24 hours to am pm
                          Text(
                            "3.35 PM",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "To ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.date_range_rounded,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "June 11,2022",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.watch_later_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10),
                          // NOTE 24 hours to am pm
                          Text(
                            "3.35 PM",
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//NOTE ----------My Divider -----------------------------
Widget myDivider() => Container(
      color: Colors.grey,
      width: double.infinity,
      height: 1,
    );

Widget defaultTextFormField(
        {required TextEditingController controller,
        required TextInputType inputtype,
        Function(String?)? onfieldsubmit,
        VoidCallback? ontap,
        String? Function(String?)? onvalidate,
        Function(String?)? onchange,
        String? text,
        Widget? prefixIcon,
        Widget? suffixIcon,
        bool obscure = false,
        InputBorder? border,
        String? hinttext,
        int? maxligne,
        bool readonly = false}) =>
    TextFormField(
        controller: controller,
        keyboardType: inputtype,
        onFieldSubmitted: onfieldsubmit,
        onTap: ontap,
        maxLines: maxligne ?? 1,
        readOnly: readonly,
        obscureText: obscure,
        onChanged: onchange,
        style: TextStyle(
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          labelText: text,
          hintText: hinttext ?? null,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: border ?? OutlineInputBorder(),
        ),
        validator: onvalidate);

//NOTE ----------default Button -----------------------------
Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        VoidCallback? onpress,
        required String text,
        double radius = 0,
        double height = 40,
        LinearGradient? gradient,
        bool? isUppercase}) =>
    Container(
      width: width,
      child: MaterialButton(
        height: height,
        onPressed: onpress,
        child: Text(
          (isUppercase != null && isUppercase) ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
          gradient: gradient),
    );
