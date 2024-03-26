import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/constants/global_variable.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/home/provider/request_item_provider.dart';
import 'package:approvelt/features/home/screens/add_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> filterList = <String>[
  'All',
  'Approved',
  'Denied',
  'Not Checked',
  'Expired'
];

final dropDownStateValueProvider =
    StateProvider<String>((ref) => filterList.first);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final fromDateController = TextEditingController();
  final toDateController = TextEditingController();

  void updateFilterData(String value, WidgetRef ref) {
    ref.read(dropDownStateValueProvider.notifier).update((state) => value);
    ref.read(requestProvider.notifier).updateFetchData();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userModelProvider);
    final reqProvider = ref.watch(fetchDataProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Hi, ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    userModel.name == ''
                        ? "UNKNOWN"
                        : " ${userModel.name.toUpperCase()}",
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  const Text(
                    "Sort By",
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  DropdownButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                    alignment: Alignment.center,
                    value: ref.watch(dropDownStateValueProvider),
                    items: filterList
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap: () => updateFilterData(value, ref),
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      ref
                          .read(dropDownStateValueProvider.notifier)
                          .update((state) => value!);
                    },
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                ],
              ),
              if (userModel.type == 'user')
                defaultButton(
                    text: "Add Request",
                    width: 120,
                    onpress: () {
                      Navigator.pushNamed(context, AddEventScreen.routeName);
                    },
                    gradient: blueGradient,
                    radius: 8),
              const SizedBox(
                width: 8,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => RequestItem(
                      itemModel: reqProvider[index],
                      context: context,
                    ),
                itemCount: reqProvider.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider()),
          ),
        ],
      ),
    );
  }
}
