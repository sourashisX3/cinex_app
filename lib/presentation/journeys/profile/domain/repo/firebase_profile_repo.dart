import 'package:cinex_app/data/di/dependency_init.dart';
import 'package:cinex_app/presentation/journeys/profile/domain/model/profile_user.dart';
import 'package:cinex_app/presentation/journeys/profile/domain/repo/profile_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProfileRepo implements ProfileRepo {
  final FirebaseFirestore firebaseFirestore = getIt<FirebaseFirestore>();

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      /// get user doc from the firestore
      final userDoc = await firebaseFirestore
          .collection("users")
          .doc(uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data();
        if (userData != null) {
          return ProfileUser(
            uid: uid,
            email: userData["email"],
            name: userData["name"],
            phoneNumber: userData["phoneNumber"],
          );
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileUser updateProfile) async {
    try {
      // Only update name, phone number, and email address
      await firebaseFirestore
          .collection("users")
          .doc(updateProfile.uid)
          .update({
            "name": updateProfile.name,
            "phoneNumber": updateProfile.phoneNumber,
            "email": updateProfile.email,
          });
    } catch (e) {
      throw Exception(e);
    }
  }
}
