import 'package:bloc/bloc.dart';
import 'package:firebase/data/repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // ميثود تسجيل الدخول
  void loginWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.loginWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (response is UserCredential) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  // ميثود إنشاء حساب جديد
  void registerWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    emit(AuthLoadingState());
    final response = await AuthRepo.registerWithEmailAndPassword(
      emailAddress: emailAddress,
      password: password,
    );
    if (response is UserCredential) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }
}
