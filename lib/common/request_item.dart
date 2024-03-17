import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/features/home/screens/display_item_card.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:flutter/material.dart';

class RequestItem extends StatelessWidget {
  final BuildContext context;
  final RequestItemModel itemModel;
  const RequestItem(
      {super.key, required this.itemModel, required this.context});

  @override
  Widget build(BuildContext context) {
    final DateTime endDateInDateTime = DateTime.parse(itemModel.endDate);
    final DateTime dateNowInDateTime =
        DateTime.parse(DateTime.now().toString().split(' ')[0]);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), gradient: orangeGradient),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    itemModel.subject,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(
                        context, DisplayItemCard.routeName,
                        arguments: itemModel),
                    child: const Icon(
                      Icons.arrow_forward,
                    ))
              ],
            ),
            Divider(
              color: Colors.grey.shade400,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          // "June 11,2022",
                          itemModel.startDate,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                const Text(
                  "To ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.date_range_rounded,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          // "June 11,2022",
                          itemModel.endDate,
                          style: const TextStyle(
                              fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 40,
              width: 120,
              decoration: BoxDecoration(
                  gradient: endDateInDateTime.isBefore(dateNowInDateTime)
                      ? redGradient
                      : itemModel.isApproved
                          ? greenGradient
                          : itemModel.isDenied
                              ? redGradient
                              : purpleGradient,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Center(
                  child: Text(
                endDateInDateTime.isBefore(dateNowInDateTime)
                    ? "Expired!"
                    : itemModel.isApproved
                        ? "Approved"
                        : itemModel.isDenied
                            ? "Denied"
                            : "Not Approved",
              )),
            )
          ],
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
        style: const TextStyle(
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
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
