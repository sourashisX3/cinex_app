import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/extensions/common_functions.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/profile_avatar.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/theme_button.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/data/bloc/theme_bloc/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeAppBar extends StatelessWidget {
  final String? userName;
  final String? imageUrl;
  const HomeAppBar({super.key, this.userName, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        ProfileAvatar(imageUrl: imageUrl),
        // Greetings and subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStringConstants.homeTitle(userName ?? "User"),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColor.primaryActionColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: Sizes.dimen_4),
              Builder(
                builder: (context) {
                  final isSmall = getScreenWidth(context) < Sizes.dimen_360;
                  return Text(
                    AppStringConstants.homeSubTitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: isSmall ? 1 : 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  );
                },
              ),
            ],
          ),
        ),
        // Theme toggle button
        ThemeButton(
          onTap: () {
            BlocProvider.of<ThemeCubit>(context).toggleTheme();
          },
        ),
      ],
    );
  }
}
