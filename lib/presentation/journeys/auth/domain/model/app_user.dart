class AppUser {
  final String uid;
  final String email;
  final String phoneNumber;
  final String name;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'phoneNumber': phoneNumber,
      'email': email,
      'name': name,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
      phoneNumber: jsonUser['phoneNumber'],
    );
  }
}
