import 'package:cinex_app/data/di/dependency_init.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../data/data_sources/data_sources_hive_database.dart';
import '../../themes/app_color.dart';

class UnauthenticatedScreen extends StatelessWidget {
  const UnauthenticatedScreen({super.key});
  @override
  Widget build(BuildContext context) {
    HiveDatabase().removeUserSfData();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Lottie.asset(
                'assets/animations/login.json',
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35),
              child: Text(
                'OPPS!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).cardColor,
                ),
                maxLines: 4,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 24),
              child: Text(
                "Your session has expired.\nPlease login again to continue",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.black54,
                ),
                maxLines: 4,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: OutlinedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(const Size(50, 30)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 55),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  overlayColor: WidgetStateProperty.all(Colors.red.shade50),
                  elevation: WidgetStateProperty.all(12),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                    color: AppColor.primaryActionColor,
                  ),
                ),
                onPressed: () {
                  // openScreenWithoutBack(context, const SignIn());
                  getIt<HiveDatabase>().removeUserSfData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
