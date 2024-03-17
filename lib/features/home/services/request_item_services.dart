import 'dart:developer';
import 'package:approvelt/constants/typedefs.dart';
import 'package:approvelt/models/request_item_model.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

class RequestItemService {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseAuth auth = FirebaseAuth.instance;

  static FutureVoid addRequestItem(String subject, String description,
      String startDate, String endDate) async {
    try {
      var allReqDocs = await firestore.collection('Requests').get();
      int len = allReqDocs.docs.length;
      String uid = auth.currentUser!.uid;
      RequestItemModel itemModel = RequestItemModel(
          id: "Request $len",
          uid: uid,
          subject: subject,
          description: description,
          isApproved: false,
          approvedBy: '',
          startDate: startDate,
          endDate: endDate,
          isDenied: false,
          deniedBy: '');

      await firestore
          .collection('Requests')
          .doc('Request $len')
          .set(itemModel.toMap());
      return right(log("Request Item is Added"));
    } catch (e) {
      return left(e.toString());
    }
  }

  static Stream<List<RequestItemModel>> fetchData(UserModel userModel) {
    CollectionReference<Map<String, dynamic>> collectionReference =
        firestore.collection('Requests');
    String type = userModel.type;
    String uid = userModel.uid;

    if (type == 'user') {
      Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
          collectionReference.where('uid', isEqualTo: uid).snapshots();
      return snapshot.map((event) {
        final listOfQuerySnapshots = event.docs;
        return listOfQuerySnapshots
            .map((querysnapshot) =>
                RequestItemModel.fromMap(querysnapshot.data()))
            .toList();
      });
    }

    // if (type == 'admin')
    Stream<QuerySnapshot<Map<String, dynamic>>> snapshot =
        collectionReference.where('isDenied', isEqualTo: false).snapshots();
    return snapshot.map((event) {
      final listOfQuerySnapshots = event.docs;
      return listOfQuerySnapshots
          .map(
              (querysnapshot) => RequestItemModel.fromMap(querysnapshot.data()))
          .toList();
    });
  }
}
