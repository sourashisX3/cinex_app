import 'package:flutter/material.dart';
import '../flutter_animator/widgets/zooming_entrances/zoom_in.dart';

class ProgressImage extends StatelessWidget {
  final Color cardBgColor;
  final double cardElevation;
  final double extendSize;

  const ProgressImage(
      {super.key,
      required this.cardBgColor,
      required this.cardElevation,
      required this.extendSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ZoomIn(
        child: Card(
          color: cardBgColor,
          elevation: cardElevation,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50.0),
            ),
          ),
          //shadowColor: Colors.orange.shade100,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                margin: const EdgeInsets.all(24),
                width: 70 + extendSize,
                height: 70 + extendSize,
                child: CircularProgressIndicator(
                  // TODO: change the progress color
                  // color: AppColor.yellowRegular,
                ),
              ),
              /* Image.asset(
                // TODO: change the logo here
                Assets.appAppLogo,
                fit: BoxFit.contain,
                width: 40 + extendSize,
                height: 40 + extendSize,
                // color: AppColor.primaryColorDeepDark,
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
