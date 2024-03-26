// ignore: file_names
import 'package:approvelt/common/request_item.dart';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/home/services/admin_service.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminStateProvider = StateNotifierProvider<AdminController, bool>(
    (ref) => AdminController(ref: ref));

class AdminController extends StateNotifier<bool> {
  final Ref ref;
  AdminController({required this.ref}) : super(false);

  void approveRequest(BuildContext context) async {
    state = true;
    RequestItemModel itemModel = ref.read(requestItemModelProvider)!;
    final result = await AdminServices.approveRequest(
        itemModel, ref.read(userModelProvider));
    result.fold((e) {
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }, (r) {
      RequestItemModel newItem = itemModel.copyWith(
          isApproved: true,
          isDenied: false,
          approvedBy: ref.read(userModelProvider).name);
      ref.read(requestItemModelProvider.notifier).update((state) => newItem);
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Approved")));
    });
  }

  void denyRequest(BuildContext context) async {
    state = true;
    RequestItemModel itemModel = ref.read(requestItemModelProvider)!;
    final result =
        await AdminServices.denyRequest(itemModel, ref.read(userModelProvider));
    result.fold((e) {
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }, (r) {
      RequestItemModel newItem = itemModel.copyWith(
          isApproved: false,
          isDenied: true,
          deniedBy: ref.read(userModelProvider).name);
      ref.read(requestItemModelProvider.notifier).update((state) => newItem);
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Request Denied")));
    });
  }
}
