import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/features/auth/services/auth_service.dart';
import 'package:approvelt/features/home/screens/home_screen.dart';
import 'package:approvelt/features/home/services/request_item_services.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchDataProvider = StateProvider<List<RequestItemModel>>((ref) => []);
final fetchUserCardItem = StateProvider<List<UserModel>>((ref) => []);
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
        List<RequestItemModel> filteredList = filterRequestsModel(event);
        ref.read(fetchDataProvider.notifier).update((state) => filteredList);
      });
    });
  }

  Future<void> addRequestItemModel(String subject, String description,
      String startDate, String endDate, BuildContext context) async {
    state = true;
    String username = ref.read(userModelProvider).name;
    String uidEmail = ref.read(userModelProvider).email;
    // String uidPhotoUrl = ref.read(userModelProvider).uidPhotoUrl;
    final result = await RequestItemService.addRequestItem(
        subject, description, startDate, endDate, username, uidEmail, '');

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

  List<RequestItemModel> filterRequestsModel(List<RequestItemModel> list) {
    String sortBy = ref.read(dropDownStateValueProvider);
    switch (sortBy) {
      case 'All':
        return list;

      case "Approved":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          if (element.isApproved) {
            retList.add(element);
          }
        }
        return retList;

      case "Denied":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          if (element.isDenied) {
            retList.add(element);
          }
        }

        return retList;

      case "Not Checked":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          if (!element.isApproved && !element.isDenied) {
            retList.add(element);
          }
        }
        return retList;

      case "Expired":
        List<RequestItemModel> retList = [];
        for (var element in list) {
          DateTime date = DateTime.parse(element.endDate);
          if (DateTime.now().isAfter(date)) {
            retList.add(element);
          }
        }
        return retList;

      default:
        return [];
    }
  }
}
