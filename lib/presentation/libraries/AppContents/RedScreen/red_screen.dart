import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../themes/app_color.dart';
import 'FlutterPhoenix/flutter_phoenix.dart';

//How to use
/*ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
  return RedScreen(onReload: (){
    Phoenix.rebirth(context);
  },);
};*/

//This screen is replaced screen of default error red screen
class RedScreen extends StatelessWidget {
  const RedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  Assets.animationsSomethingWrong,
                  width: getScreenWidth(context),
                  height: 250,
                ),
                const Text(
                  'OOPS!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: AppColor.white,
                  ),
                  maxLines: 4,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Something went wrong.\nPlease try again.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                    maxLines: 4,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: OutlinedButton(
                    onPressed: () {
                      Phoenix.rebirth(context);
                    },
                    style: ButtonStyle(
                      //minimumSize: MaterialStateProperty.all(const Size(50, 30)),
                      padding: WidgetStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 55),
                      ),
                      backgroundColor: WidgetStateProperty.all(Colors.green),

                      elevation: WidgetStateProperty.all(6),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: const BorderSide(
                            color: Colors.green,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      'Reload',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
