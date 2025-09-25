import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../generated/assets.dart';

class NoDataFound extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final String? lottie;
  final String? retryTxt;
  final Function() onRefresh;

  const NoDataFound({
    super.key,
    required this.onRefresh,
    this.title,
    this.subTitle,
    this.lottie,
    this.retryTxt,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: (retryTxt ?? '').isEmpty ? 0 : 50,
              ),
              child: SizedBox(
                height: 180, // or any height you want
                width: 180, // or any width you want
                child: Lottie.asset(
                  lottie ?? Assets.animationsEmptySearchData,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          if ((title ?? '').isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 3.h),
              child: Text(
                title ?? 'OPPS!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontFamily: FontFamilyConstants.zalandoSansBold,
                ),
                maxLines: 4,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if ((retryTxt ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: OutlinedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all(const Size(50, 30)),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 55),
                  ),
                  backgroundColor: WidgetStateProperty.all(Colors.white),
                  overlayColor: WidgetStateProperty.all(Colors.orange.shade50),
                  elevation: WidgetStateProperty.all(12),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                onPressed: onRefresh,
                child: Text(
                  retryTxt ?? 'Retry',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
