import 'dart:developer';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/constants/theme.dart';
import 'package:approvelt/features/home/provider/request_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEventScreen extends ConsumerWidget {
  AddEventScreen({super.key});
  static const String routeName = "/home/add_screen";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final titlecontroller = TextEditingController();
  final descriptionController = TextEditingController();
  final fromDatecontroller = TextEditingController();
  final toDatecontroller = TextEditingController();
  final starttimeController = TextEditingController();
  final endtimeController = TextEditingController();

  String convertToFullDate(String timeAM, String date) {
    DateTime val = DateFormat("hh:mm a").parse(timeAM);
    var tdate = val.toString().split(' ');
    tdate[0] = date;
    String fromDate = "${tdate[0]} ${tdate[1]}";
    return fromDate;
  }

  void saveRequestItem(WidgetRef ref, BuildContext context) async {
    String fromDateFull =
        convertToFullDate(starttimeController.text, fromDatecontroller.text);
    String toDateFull =
        convertToFullDate(endtimeController.text, toDatecontroller.text);
    ref.read(requestProvider.notifier).addRequestItemModel(titlecontroller.text,
        descriptionController.text, fromDateFull, toDateFull, context);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(requestProvider);
    return Scaffold(
      appBar: _appbar(context, ref),
      body: isLoading ? const LoadingScreen() : _buildFromAddTask(context),
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
                          return null;
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
                          return "description must not be empty";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
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
                                return null;
                              },
                              text: "From date"),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: defaultTextFormField(
                              readonly: true,
                              controller: starttimeController,
                              inputtype: TextInputType.number,
                              prefixIcon:
                                  const Icon(Icons.watch_later_outlined),
                              ontap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  // print(value!.format(context).toString());
                                  starttimeController.text =
                                      value!.format(context).toString();

                                  //! 1970-01-01 time selected:00.000
                                  // print(DateFormat("hh:mm a").parse(
                                  //     starttimeController.text.toString()));
                                });
                              },
                              onvalidate: (value) {
                                if (value!.isEmpty) {
                                  return "time must not be empty";
                                }
                                return null;
                              },
                              text: "From"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: defaultTextFormField(
                              readonly: true,
                              controller: toDatecontroller,
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
                                  toDatecontroller.text = tdate[0];
                                });
                              },
                              onvalidate: (value) {
                                if (value == null || value.isEmpty) {
                                  return "date must not be empty";
                                }
                                return null;
                              },
                              text: "To date"),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: defaultTextFormField(
                              readonly: true,
                              controller: endtimeController,
                              inputtype: TextInputType.number,
                              prefixIcon:
                                  const Icon(Icons.watch_later_outlined),
                              ontap: () {
                                showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                    .then((value) {
                                  // print(value!.format(context).toString());
                                  endtimeController.text =
                                      value!.format(context).toString();
                                  // print(endtimeController.text);
                                  //! 1970-01-01 time selected:00.000
                                  // print(DateFormat("hh:mm a").parse(
                                  //     endtimeController.text.toString()));
                                });
                              },
                              onvalidate: (value) {
                                if (value!.isEmpty) {
                                  return "time must not be empty";
                                }
                                return null;
                              },
                              text: "To"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  _appbar(BuildContext context, WidgetRef ref) {
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
                log("coming");
                saveRequestItem(ref, context);
              }
            },
            icon: const Icon(
              Icons.done,
              color: Colors.black,
            ),
            label: const Text("Save"),
          ),
        )
      ],
    );
  }
}
