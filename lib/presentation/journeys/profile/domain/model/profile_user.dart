import 'package:cinex_app/presentation/journeys/auth/domain/model/app_user.dart';

class ProfileUser extends AppUser {

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required super.phoneNumber,
  });

  // update user --------------
  ProfileUser copyWith({String? newBio, String? newProfileImageUrl}) {
    return ProfileUser(
      uid: uid,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
    );
  }

  // profile user -> json ----------------
  @override
  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "name": name,
      "phoneNumber": phoneNumber,
    };
  }

  // json -> profile user ------------------
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json["uid"],
      email: json["email"],
      name: json["name"],
      phoneNumber: json["phoneNumber"],
    );
  }
}
