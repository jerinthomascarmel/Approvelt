import 'package:approvelt/features/auth/services/auth_service.dart';
import 'package:approvelt/features/home/screens/home_screen.dart';
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
      ref.read(requestProvider.notifier).updateFetchData();
      state = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e)));
    }, (r) {
      ref.read(requestProvider.notifier).updateFetchData();
      state = false;
      Navigator.pop(context);
    });
  }

  void filterRequests(String sortBy) {
    List<RequestItemModel> list = ref.read(fetchDataProvider);
    switch (sortBy) {
      case 'All':
        ref.read(filteredDataProvider.notifier).update((state) => list);
        break;

      case "Approved":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          if (element.isApproved) {
            retList.add(element);
          }
        }
        ref.read(filteredDataProvider.notifier).update((state) => retList);
        break;
      case "Denied":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          if (element.isDenied) {
            retList.add(element);
          }
        }
        ref.read(filteredDataProvider.notifier).update((state) => retList);
        break;

      case "Not Approved":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          if (!element.isApproved && !element.isDenied) {
            retList.add(element);
          }
        }
        ref.read(filteredDataProvider.notifier).update((state) => retList);
        break;

      case "Expired":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          DateTime date = DateTime.parse(element.endDate);
          if (DateTime.now().isBefore(date)) {
            retList.add(element);
          }
        }
        ref.read(filteredDataProvider.notifier).update((state) => retList);
        break;
    }
  }
}
