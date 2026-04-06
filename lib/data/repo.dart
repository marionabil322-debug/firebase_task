import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  // ميثود تسجيل الدخول (Login)
  static Future loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        // تعديل هنا لـ signIn
        email: emailAddress,
        password: password,
      );
      return credential;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // ميثود إنشاء حساب جديد (Register)
  static Future registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            // هنا الـ Create
            email: emailAddress,
            password: password,
          );
      return credential;
    } catch (e) {
      print(e);
      return e;
    }
  }

  // ميثود جوجل كما هي عندك...
}
