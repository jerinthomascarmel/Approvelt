import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/auth/services/auth_service.dart';
import 'package:approvelt/features/home/services/request_item_services.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchDataProvider = StateProvider<List<RequestItemModel>>((ref) => []);
final requestProvider =
    StateNotifierProvider<RequestProvider, bool>((ref) => RequestProvider(ref));

final fetchDataStreamProvider =
    StreamProvider.family<List<RequestItemModel>, UserModel>(
        (ref, UserModel userModel) =>
            ref.read(requestProvider.notifier).fetchData(userModel));

class RequestProvider extends StateNotifier<bool> {
  RequestProvider(this.ref) : super(false);
  final Ref ref;

  Stream<List<RequestItemModel>> fetchData(UserModel userModel) {
    return RequestItemService.fetchData(userModel);
  }

  void updateFetchData() {
    var userStream = AuthService.getCurrentUserModelStream();
    userStream.listen((UserModel userModel) {
      fetchData(userModel).listen((event) {
        ref.read(fetchDataProvider.notifier).update((state) => event);
      });
    });
  }

  Future<void> addRequestItemModel(String subject, String description,
      String startDate, String endDate, BuildContext context) async {
    state = true;
    final result = await RequestItemService.addRequestItem(
        subject, description, startDate, endDate);

    result.fold((e) {
      state = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    }, (r) {
      state = false;
      Navigator.pop(context);
    });
  }
}
