import 'package:cinex_app/data/di/dependency_init.dart';
import 'package:cinex_app/presentation/journeys/auth/domain/model/app_user.dart';
import 'package:cinex_app/presentation/journeys/auth/domain/repo/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = getIt<FirebaseAuth>();
  final FirebaseFirestore firebaseFirestore = getIt<FirebaseFirestore>();

  @override
  Future<AppUser?> getCurrentUser() async {
    /// get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    /// no user logged in
    if (firebaseUser == null) {
      return null;
    }

    /// user exists
    // Fetch phone number from Firestore if available
    String phoneNumber = "";
    try {
      final userDoc = await firebaseFirestore
          .collection("users")
          .doc(firebaseUser.uid)
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        phoneNumber = userDoc.data()!["phoneNumber"] ?? "";
      }
    } catch (e) {
      // ignore error, fallback to empty phone number
    }
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      name: "",
      phoneNumber: phoneNumber,
    );
  }

  @override
  Future<AppUser?> logInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      /// attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // Fetch phone number from Firestore if available
      String phoneNumber = "";
      try {
        final userDoc = await firebaseFirestore
            .collection("users")
            .doc(userCredential.user!.uid)
            .get();
        if (userDoc.exists && userDoc.data() != null) {
          phoneNumber = userDoc.data()!["phoneNumber"] ?? "";
        }
      } catch (e) {
        // ignore error, fallback to empty phone number
      }

      /// create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: "",
        phoneNumber: phoneNumber,
      );

      /// return user
      return user;
    } catch (e) {
      throw Exception("Login failed $e");
    }
  }

  @override
  Future<AppUser?> signUpWithEmailAndPassword(
    String name,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      /// attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      /// create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        phoneNumber: phoneNumber,
        email: email,
        name: name,
      );

      /// save user data in the firestore
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());

      /// return user
      return user;
    } catch (e) {
      throw Exception("Sign up failed $e");
    }
  }

  @override
  Future<void> logOut() async {
    await firebaseAuth.signOut();
  }
}
