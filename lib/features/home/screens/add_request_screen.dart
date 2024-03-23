import 'dart:developer';
import 'package:approvelt/common/loader_screen.dart';
import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/constants/theme.dart';
import 'package:approvelt/features/home/provider/request_item_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEventScreen extends ConsumerWidget {
  AddEventScreen({super.key});
  static const String routeName = "/home/add_screen";

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final titlecontroller = TextEditingController();
  final descriptionController = TextEditingController();
  final fromDatecontroller = TextEditingController();
  final toDatecontroller = TextEditingController();

  void saveRequestItem(WidgetRef ref, BuildContext context) async {
    ref.read(requestProvider.notifier).addRequestItemModel(
        titlecontroller.text,
        descriptionController.text,
        fromDatecontroller.text,
        toDatecontroller.text,
        context);
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
                          return "title must not be empty";
                        }
                        return null;
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
                              return null;
                            },
                            text: "From date"),
                        const SizedBox(
                          height: 5,
                        ),
                        defaultTextFormField(
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
