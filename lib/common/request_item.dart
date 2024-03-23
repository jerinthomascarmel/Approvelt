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
      margin: EdgeInsetsDirectional.symmetric(horizontal: 5),
      // height: 310,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white, border: Border.all(color: Colors.grey)),
      child: Column(children: [
        ListTile(
          leading: const CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/defaultprofile.png"),
          ),
          title: Text(itemModel.nameSentBy),
          subtitle: Text("jovin@gmail.com (to change)"),
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
                    Text(itemModel.subject),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
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
                        Text(
                          "start date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          itemModel.startDate,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "9 PM",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "end date",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          itemModel.endDate,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          "9 PM",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
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
