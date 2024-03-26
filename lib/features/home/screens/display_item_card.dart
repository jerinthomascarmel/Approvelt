import 'package:approvelt/common/conversion_date_time.dart';
import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/home/provider/Admin_controller.dart';
import 'package:approvelt/features/home/screens/qr_code_screen.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DisplayItemCard extends ConsumerStatefulWidget {
  static const String routeName = "home/item_card";
  const DisplayItemCard({super.key});
  @override
  ConsumerState<DisplayItemCard> createState() => _DisplayItemCard();
}

class _DisplayItemCard extends ConsumerState<DisplayItemCard> {
  void approveRequest(WidgetRef ref, BuildContext context) {
    ref.read(adminStateProvider.notifier).approveRequest(context);
    setState(() {});
  }

  void denyRequest(WidgetRef ref, BuildContext context) {
    ref.read(adminStateProvider.notifier).denyRequest(context);
    setState(() {});
  }

  void navigateToQR(BuildContext context, RequestItemModel requestItemModel) {
    Navigator.pushNamed(
      context,
      QRImage.routeName,
      arguments: requestItemModel,
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isAcceptClicked = true;
    final isLoading = ref.watch(adminStateProvider);
    final RequestItemModel itemModel = ref.watch(requestItemModelProvider)!;
    final DateTime endDateInDateTime = DateTime.parse(itemModel.endDate);
    final DateTime dateNowInDateTime =
        DateTime.parse(DateTime.now().toString().split(' ')[0]);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
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
                    subtitle: Text(itemModel.uidEmail),
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
                          fontSize: 17, fontWeight: FontWeight.normal),
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
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.date_range),
                                  Text(
                                    dateToDate(itemModel.startDate),
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.lock_clock),
                                  Text(
                                    dateToTime(itemModel.startDate),
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 15),
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
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 15),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.date_range),
                                  Text(
                                    dateToDate(itemModel.endDate),
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 15),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.lock_clock),
                                  Text(
                                    dateToTime(itemModel.endDate),
                                    style: const TextStyle(
                                        color: Colors.black87, fontSize: 15),
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
                        dateNowInDateTime.isAfter(endDateInDateTime)
                            ? const SizedBox()
                            : (itemModel.isApproved == itemModel.isDenied)
                                ? const SizedBox()
                                : itemModel.isApproved
                                    ? Column(
                                        children: [
                                          const Text("Approved By"),
                                          Text(
                                            itemModel.approvedBy,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          const Text("Denied By"),
                                          Text(
                                            itemModel.deniedBy,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                        const Spacer(),
                        Container(
                          width: 120,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue.shade900),
                          child: Center(
                            child: Text(
                              dateNowInDateTime.isAfter(endDateInDateTime)
                                  ? "Expired"
                                  : (itemModel.isApproved == itemModel.isDenied)
                                      ? "Not Checked"
                                      : itemModel.isApproved
                                          ? "Approved"
                                          : "Denied",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (ref.read(userModelProvider).type == "admin")
                      Row(
                        children: [
                          Expanded(
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      iconColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => !itemModel.isApproved
                                                  ? Colors.grey.shade700
                                                  : Colors.grey),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ))),
                                  onPressed: !itemModel.isApproved
                                      ? () {
                                          isAcceptClicked = true;
                                          approveRequest(ref, context);
                                        }
                                      : null,
                                  icon: const Icon(Icons.abc),
                                  label: (isAcceptClicked && isLoading)
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          "Accept",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                          const SizedBox(
                            width: 7,
                          ),
                          Expanded(
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      iconColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.resolveWith(
                                              (states) => !itemModel.isDenied
                                                  ? Colors.grey.shade700
                                                  : Colors.grey),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ))),
                                  onPressed: !itemModel.isDenied
                                      ? () {
                                          isAcceptClicked = false;
                                          denyRequest(ref, context);
                                        }
                                      : null,
                                  icon: const Icon(Icons.abc),
                                  label: (!isAcceptClicked && isLoading)
                                      ? const CircularProgressIndicator()
                                      : const Text(
                                          "Reject ",
                                          style: TextStyle(color: Colors.white),
                                        ))),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            if (ref.read(userModelProvider).type == 'user')
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
                            onPressed: () => navigateToQR(context, itemModel),
                            icon: const Icon(Icons.qr_code),
                            label: const Text(
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
