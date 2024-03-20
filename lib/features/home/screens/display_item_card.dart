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
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  gradient: orangeGradient),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      itemModel.subject,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (itemModel.isApproved)
                          const Text(
                            "Approved By,\nDr.Shajulin",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 30),
                          ),
                        if (!itemModel.isApproved)
                          const Text(
                            "Not \nApproved Yet!",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 30),
                          ),
                        const Spacer(),
                        defaultButton(
                            text: endDateInDateTime.isBefore(dateNowInDateTime)
                                ? "Expired!"
                                : itemModel.isApproved
                                    ? "Approved"
                                    : itemModel.isDenied
                                        ? "Denied"
                                        : "Not Approved",
                            width: 120,
                            onpress: () {},
                            gradient:
                                endDateInDateTime.isBefore(dateNowInDateTime)
                                    ? redGradient
                                    : itemModel.isApproved
                                        ? greenGradient
                                        : itemModel.isDenied
                                            ? redGradient
                                            : purpleGradient,
                            radius: 15),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 12),
                    child: Row(
                      children: [
                        Text(
                          "starts: ${itemModel.startDate}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        const Spacer(),
                        Text("expires: ${itemModel.endDate}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: orangeGradient),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    " Description: ",
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 117, 112, 112))),
                      child: Text(
                        itemModel.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            if (ref.watch(userModelProvider).type == "user")
              defaultButton(
                  height: 60,
                  text: "Get the QR Code",
                  width: double.infinity,
                  onpress: () => navigateToQR(context, itemModel),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 255, 198, 9),
                    Colors.deepOrange,
                  ]),
                  radius: 15),
            const SizedBox(
              height: 10,
            ),
            if (ref.watch(userModelProvider).type == "admin")
              Row(
                children: [
                  Expanded(
                    child: defaultButton(
                        text: !isLoading ? "Approve" : "loading...",
                        width: double.infinity,
                        onpress: () => approveRequest(itemModel, ref, context),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 198, 9),
                          Colors.deepOrange,
                        ]),
                        radius: 15),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: defaultButton(
                        text: isLoading ? "loading.." : "Deny",
                        width: double.infinity,
                        onpress: () => denyRequest(itemModel, ref, context),
                        gradient: const LinearGradient(colors: [
                          Color.fromARGB(255, 255, 198, 9),
                          Colors.deepOrange,
                        ]),
                        radius: 15),
                  ),
                ],
              ),
          ]),
        ),
      ),
    );
  }
}
