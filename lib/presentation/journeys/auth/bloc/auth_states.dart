import 'package:cinex_app/presentation/journeys/auth/domain/model/app_user.dart';

abstract class AuthState {}

/// initial
class AuthInitial extends AuthState {}

/// loading
class AuthLoading extends AuthState {}

/// authenticated
class Authenticated extends AuthState {
  final AppUser user;

  Authenticated(this.user);
}

/// unauthenticated
class Unauthenticated extends AuthState {}

/// errors
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
