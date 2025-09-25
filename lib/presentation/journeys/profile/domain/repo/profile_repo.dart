

import 'package:cinex_app/presentation/journeys/profile/domain/model/profile_user.dart';

abstract class ProfileRepo {
  Future<ProfileUser?> fetchUserProfile(String uid);

  Future<void> updateProfile(ProfileUser updateProfile);
}
