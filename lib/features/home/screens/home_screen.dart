import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/features/home/screens/add_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Hi, ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "JERIN",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              defaultButton(
                  text: "Add Request",
                  width: 120,
                  onpress: () {
                    Navigator.pushNamed(context, AddEventScreen.routeName);
                  },
                  gradient: orangeGradient,
                  radius: 15),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => const RequestItem(),
              itemCount: 5,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ),
          )
        ],
      ),
    );
  }
}
