import 'dart:io';
import 'package:approvelt/features/auth/providers/auth_provider.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final userProfileStateProvider =
    StateNotifierProvider<UserController, bool>((ref) => UserController(ref));

class UserController extends StateNotifier<bool> {
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final Ref ref;
  UserController(this.ref) : super(false);

  Future<File?> pickImage(BuildContext context) async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  // upload to firebase storage
  Future<String> uploadToStorage(File image) async {
    Reference ref =
        firebaseStorage.ref().child('profilePics').child(auth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void updateProfile(BuildContext context) async {
    File? pickedImage = await pickImage(context);
    if (pickedImage == null) {
      return;
    }
    state = true;
    String downloadUrl = await uploadToStorage(pickedImage);
    UserModel userModel =
        ref.read(userModelProvider).copyWith(uidPhotoUrl: downloadUrl);
    await firestore
        .collection('users')
        .doc(userModel.uid)
        .update({"uidPhotoUrl": downloadUrl});
    state = false;
    //update usermodelProvider
    ref.read(userModelProvider.notifier).update((state) => userModel);
  }
}
