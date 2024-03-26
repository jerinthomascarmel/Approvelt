
import 'package:approvelt/features/home/screens/display_item_card.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'conversion_date_time.dart';

final requestItemModelProvider =
    StateProvider<RequestItemModel?>((ref) => null);

class RequestItem extends ConsumerWidget {
  final BuildContext context;
  final RequestItemModel itemModel;
  const RequestItem(
      {super.key, required this.itemModel, required this.context});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime endDateInDateTime = DateTime.parse(itemModel.endDate);
    final DateTime dateNowInDateTime =
        DateTime.parse(DateTime.now().toString().split(' ')[0]);
    return Container(
      margin: const EdgeInsetsDirectional.symmetric(horizontal: 5),
      // height: 310,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/defaultprofile.png"),
          ),
          title: Text(itemModel.nameSentBy),
          subtitle: Text(itemModel.uidEmail),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.info_outline),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      itemModel.subject,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          ref
                              .read(requestItemModelProvider.notifier)
                              .update((state) => itemModel);
                          Navigator.pushNamed(
                            context,
                            DisplayItemCard.routeName,
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios)),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "      start date",
                          style: TextStyle(color: Colors.black87, fontSize: 15),
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
                            )
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "       end date",
                          style: TextStyle(color: Colors.black87, fontSize: 15),
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
          ),
        )
      ]),
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
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: text,
          hintText: hinttext,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: border ?? const OutlineInputBorder(),
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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: background,
          gradient: gradient),
      child: MaterialButton(
        height: height,
        onPressed: onpress,
        child: Text(
          (isUppercase != null && isUppercase) ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
