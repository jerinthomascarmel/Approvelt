import 'package:approvelt/constants/typedefs.dart';
import 'package:approvelt/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FutureEither<UserCredential> loginUser(
      String email, String password) async {
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return right(credential);
    } on FirebaseAuthException catch (e) {
      return left(e.toString());
    }
  }

  static FutureEither<UserCredential> registerUser(
      String email, String password, String name, String type) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      CollectionReference users = firestore.collection('users');
      String uid = userCredential.user!.uid;
      UserModel userModel = UserModel(
        uid: uid,
        email: email,
        password: password,
        name: name,
        type: type,
      );
      await users.doc(uid).set(userModel.toMap());
      return right(userCredential);
    } on FirebaseAuthException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  static Stream<UserModel> getCurrentUserModelStream() {
    String uid = auth.currentUser!.uid;
    return firestore.collection('users').doc(uid).snapshots().map((event) {
      final userMap = event.data();
      return UserModel.fromMap(userMap as Map<String, dynamic>);
    });
  }

  
}
