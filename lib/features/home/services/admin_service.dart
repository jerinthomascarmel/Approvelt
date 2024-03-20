import 'dart:developer';

import 'package:approvelt/constants/typedefs.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

class AdminServices {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FutureVoid approveRequest(
      RequestItemModel requestItemModel, UserModel userModel) async {
    try {
      String reqId = requestItemModel.id;
      String approvedBy = userModel.uid;
      await firestore.collection('Requests').doc(reqId).update(
          {"approvedBy": approvedBy, "isApproved": true, "isDenied": false});
      return right(log("approved Request"));
    } catch (e) {
      return left(e.toString());
    }
  }

  static FutureVoid denyRequest(
      RequestItemModel requestItemModel, UserModel userModel) async {
    try {
      String reqId = requestItemModel.id;
      String deniedBy = userModel.uid;
      await firestore.collection('Requests').doc(reqId).update(
          {"deniedBy": deniedBy, "isApproved": false, "isDenied": true});
      return right(log("approved Request"));
    } catch (e) {
      return left(e.toString());
    }
  }
}
