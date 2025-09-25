import 'package:cinex_app/data/data_sources/hive_database_keys.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  static late Box box;

  /// Firebase related -------------------------------
  String getFirebaseToken() {
    return HiveDatabase.box.get(HiveDatabaseKeys.firebaseDeviceToken) ?? "";
  }

  void saveFirebaseToken(String firebaseToken) async {
    await HiveDatabase.box.put(
      HiveDatabaseKeys.firebaseDeviceToken,
      firebaseToken,
    );
  }

  /// User related -------------------------------
  void removeUserSfData() async {
    debugPrint(
      "userData after delete inside function: ${HiveDatabaseKeys.userData}",
    );

    // Preserve Firebase token before clearing data
    String firebaseToken = getFirebaseToken();

    await HiveDatabase.box.delete(HiveDatabaseKeys.userData);

    final remaining = box.get(HiveDatabaseKeys.userData);
    debugPrint("userData after delete inside function: $remaining");
    await box.clear();

    // Restore Firebase token after clearing
    if (firebaseToken.isNotEmpty) {
      saveFirebaseToken(firebaseToken);
      debugPrint('---- Firebase token preserved during logout: $firebaseToken');
    }
  }
}
