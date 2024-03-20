// ignore: file_names
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

  void approveRequest(
      RequestItemModel requestItemModel, BuildContext context) async {
    state = true;
    final result = await AdminServices.approveRequest(
        requestItemModel, ref.read(userModelProvider));
    result.fold((e) {
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }, (r) {
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Approved")));
    });
  }

  void denyRequest(
      RequestItemModel requestItemModel, BuildContext context) async {
    state = true;
    final result = await AdminServices.denyRequest(
        requestItemModel, ref.read(userModelProvider));
    result.fold((e) {
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }, (r) {
      state = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Request Denied")));
    });
  }
}
