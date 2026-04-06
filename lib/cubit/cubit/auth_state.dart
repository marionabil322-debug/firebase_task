part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthErrorState extends AuthState {}

final class AuthSuccessState extends AuthState {}
