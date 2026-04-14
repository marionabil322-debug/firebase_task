import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static Future registerWithEmailAndPassword({required UserModel user}) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: user.email ?? "",
            password: user.password ?? "",
          );
      user.uid = credential.user?.uid;

      saveUserData(user);
      return credential;
    } catch (e) {
      print(e);
      return e;
    }
  }

  static saveUserData(UserModel user) async {
    await firestore.collection('users').doc(user.uid).set(user.tojson());
  }

  static final currentUser = FirebaseAuth.instance.currentUser;

  static Future<void> getUserData() async {
    if (currentUser != null) {
      final doc = await firestore
          .collection("users")
          .doc(currentUser!.uid)
          .get();

      if (doc.exists) {
        print(doc.data());
      } else {
        print("User not found in Firestore");
      }
    }
  }
}
