import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:flutter/material.dart';

class MainBannerImage extends StatelessWidget {
  final String? imageUrl;
  const MainBannerImage({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.dimen_50.h,
      width: getScreenWidth(context),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl ?? "",
            height: Sizes.dimen_50.h,
            width: getScreenWidth(context),
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                strokeWidth: Sizes.dimen_2,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white12
                  : Colors.black12,
              alignment: Alignment.center,
              child: Icon(
                Icons.image_not_supported,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white24
                    : Colors.black26,
                size: 48,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: Sizes.dimen_20.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
