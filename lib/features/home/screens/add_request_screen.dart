import 'dart:developer';
import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/constants/theme.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatelessWidget {
  static const String routeName = "/home/add_screen";
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var titlecontroller = TextEditingController();
  var fromDatecontroller = TextEditingController();
  var toDatecontroller = TextEditingController();
  var starttimecontroller = TextEditingController();
  var endtimecontroller = TextEditingController();
  var remindcontroller = TextEditingController();
  var descriptionController = TextEditingController();
  List<int> remindList = [5, 10, 15, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _buildFromAddTask(context),
    );
  }

  _buildFromAddTask(BuildContext context) => SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Request',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Form(
                key: _formkey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    defaultTextFormField(
                        controller: titlecontroller,
                        inputtype: TextInputType.text,
                        ontap: () {},
                        onvalidate: (value) {
                          if (value!.isEmpty) {
                            return "title must not be empty";
                          }
                        },
                        text: "Subject"),
                    const SizedBox(
                      height: 10,
                    ),
                    defaultTextFormField(
                      controller: descriptionController,
                      inputtype: TextInputType.text,
                      maxligne: 5,
                      text: 'Description',
                      onvalidate: (value) {
                        if (value!.isEmpty) {
                          return "title must not be empty";
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        defaultTextFormField(
                            readonly: true,
                            controller: fromDatecontroller,
                            inputtype: TextInputType.datetime,
                            prefixIcon: const Icon(Icons.date_range),
                            ontap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.parse('2010-01-01'),
                                      lastDate: DateTime.parse('2030-01-01'))
                                  .then((value) {
                                //Todo: handle date to string
                                if (value == null) return;
                                log(value.toString());
                                var tdate = value.toString().split(' ');
                                fromDatecontroller.text = tdate[0];
                              });
                            },
                            onvalidate: (value) {
                              if (value == null || value.isEmpty) {
                                return "date must not be empty";
                              }
                            },
                            text: "From date"),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultTextFormField(
                            readonly: true,
                            controller: fromDatecontroller,
                            inputtype: TextInputType.datetime,
                            prefixIcon: const Icon(Icons.date_range),
                            ontap: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.parse('2010-01-01'),
                                      lastDate: DateTime.parse('2030-01-01'))
                                  .then((value) {
                                //Todo: handle date to string
                                if (value == null) return;
                                log(value.toString());
                                var tdate = value.toString().split(' ');
                                fromDatecontroller.text = tdate[0];
                              });
                            },
                            onvalidate: (value) {
                              if (value == null || value.isEmpty) {
                                return "date must not be empty";
                              }
                            },
                            text: "To date"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _appbar(BuildContext context) {
    return AppBar(
      backgroundColor: defaultLightColor,
      leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ElevatedButton.icon(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
              } else {}
            },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
            label: const Text("Save"),
          ),
        )
      ],
    );
  }
}
