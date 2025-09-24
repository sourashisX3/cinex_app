import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/presentation/widgets/Buttons/edit_button.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';

class ProfileAvatar extends StatelessWidget {
  final String? imageUrl;
  final double size;
  final bool? isEditable;
  final VoidCallback? onEditTap;

  const ProfileAvatar({
    super.key,
    this.imageUrl,
    this.size = Sizes.dimen_50,
    this.isEditable,
    this.onEditTap,
  });

  Widget _placeholder(BuildContext context) {
    final theme = Theme.of(context);
    final effSize = size.dp;
    return Stack(
      children: [
        Container(
          width: effSize,
          height: effSize,
          decoration: BoxDecoration(
            color: theme.colorScheme.inverseSurface.withAlpha(50),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(
            Icons.person,
            size: effSize * 0.5,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        if (isEditable == true)
          Positioned(
            bottom: 0,
            right: 0,
            child: EditButton(onTap: onEditTap, size: effSize * 0.32),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final margin = const EdgeInsets.only(right: Sizes.dimen_16);
    final effSize = size.dp;

    if (imageUrl == null || imageUrl!.trim().isEmpty) {
      return Container(margin: margin, child: _placeholder(context));
    }

    return Container(
      margin: margin,
      width: effSize,
      height: effSize,
      alignment: Alignment.center,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl!,
            imageBuilder: (context, imageProvider) => Container(
              width: effSize,
              height: effSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Container(
              width: effSize,
              height: effSize,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inverseSurface,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SizedBox(
                width: effSize * 0.28,
                height: effSize * 0.28,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
            ),
            errorWidget: (context, url, error) => _placeholder(context),
          ),
          if (isEditable == true)
            Positioned(
              bottom: 0,
              right: 0,
              child: EditButton(onTap: onEditTap, size: effSize * 0.32),
            ),
        ],
      ),
    );
  }
}
