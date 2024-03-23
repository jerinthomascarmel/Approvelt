import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/home/provider/Admin_controller.dart';
import 'package:approvelt/features/home/screens/qr_code_screen.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayItemCard extends ConsumerWidget {
  static const String routeName = "home/item_card";
  const DisplayItemCard({super.key});

  void approveRequest(
      RequestItemModel requestItemModel, WidgetRef ref, BuildContext context) {
    ref
        .read(adminStateProvider.notifier)
        .approveRequest(requestItemModel, context);
  }

  void denyRequest(
      RequestItemModel requestItemModel, WidgetRef ref, BuildContext context) {
    ref
        .read(adminStateProvider.notifier)
        .denyRequest(requestItemModel, context);
  }

  void navigateToQR(BuildContext context, RequestItemModel requestItemModel) {
    Navigator.pushNamed(
      context,
      QRImage.routeName,
      arguments: requestItemModel,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(adminStateProvider);
    final RequestItemModel itemModel =
        ModalRoute.of(context)!.settings.arguments as RequestItemModel;
    final DateTime endDateInDateTime = DateTime.parse(itemModel.endDate);
    final DateTime dateNowInDateTime =
        DateTime.parse(DateTime.now().toString().split(' ')[0]);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back, size: 25)),
                        const SizedBox(
                          width: 17,
                        ),
                        const Text(
                          "Request Details",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      backgroundImage: AssetImage("assets/defaultprofile.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text(itemModel.nameSentBy),
                    subtitle: const Text("jovin@gmail.com"),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      itemModel.subject,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      itemModel.description,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "      Start date",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.date_range),
                                  Text(
                                    itemModel.startDate,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.lock_clock),
                                  Text(
                                    "9 PM",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "      End date",
                                style: TextStyle(color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.date_range),
                                  Text(
                                    itemModel.endDate,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Icon(Icons.lock_clock),
                                  Text(
                                    "9 PM",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const Column(
                          children: [
                            Text("Approved By"),
                            Text(
                              "Dr.Shajulin",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const Spacer(),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue.shade900),
                          child: const Center(
                            child: Text(
                              "Approved",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton.icon(
                          style: ButtonStyle(
                              iconColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.white),
                              backgroundColor:
                                  MaterialStateProperty.resolveWith(
                                      (states) => Colors.blue.shade900),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ))),
                          onPressed: () {},
                          icon: Icon(Icons.qr_code),
                          label: Text(
                            "Show QR Code",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ]),
            )
          ]),
        ),
      ),
    );
  }
}
