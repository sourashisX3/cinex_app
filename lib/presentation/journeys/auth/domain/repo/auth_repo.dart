import 'package:cinex_app/presentation/journeys/auth/domain/model/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> logInWithEmailAndPassword(String email, String password);
  Future<AppUser?> signUpWithEmailAndPassword(
    String name,
    String phoneNumber,
    String email,
    String password,
  );
  Future<void> logOut();
  Future<AppUser?> getCurrentUser();
}
