import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/constants/strings/button_names.dart';
import 'package:cinex_app/common/constants/strings/debugger_tags.dart';
import 'package:cinex_app/presentation/journeys/home/widgets/profile_avatar.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:cinex_app/presentation/widgets/Buttons/primary_button.dart';
import 'package:cinex_app/presentation/widgets/TextFields/modern_app_text_field.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditable = false;

  void _toggleEdit() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStringConstants.profile),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: Sizes.paddingAll16,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ---------------- avatar ----------------
                const SizedBox(height: Sizes.dimen_16),
                FadeInDown(
                  child: ProfileAvatar(
                    size: Sizes.dimen_100,
                    isEditable: _isEditable,
                    imageUrl: 'https://i.pravatar.cc/300',
                    onEditTap: () {
                      debugPrint("$debuggerTagProfile: Edit avatar tapped");
                    },
                  ),
                ),
                // ---------------- name ----------------
                const SizedBox(height: Sizes.dimen_48),
                FadeInUp(
                  preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 800),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringConstants.fullName,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamilyConstants.zalandoSansBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.dimen_8),
                FadeInUp(
                  preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 1000),
                  ),
                  child: ModernAppTextField(
                    textInputType: TextInputType.name,
                    hinttext: "John Doe",
                  ),
                ),
                // ---------------- email ----------------
                const SizedBox(height: Sizes.dimen_16),
                FadeInUp(
                  preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 1200),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringConstants.emailAddress,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamilyConstants.zalandoSansBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.dimen_8),
                FadeInUp(
                  preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 1400),
                  ),
                  child: ModernAppTextField(
                    textInputType: TextInputType.emailAddress,
                    hinttext: "xyz@gmail.com",
                  ),
                ),
                // ---------------- phone ----------------
                const SizedBox(height: Sizes.dimen_16),
                FadeInUp(
                  preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 1600),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppStringConstants.phoneNumber,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: FontFamilyConstants.zalandoSansBold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Sizes.dimen_8),
                FadeInUp(
                  preferences: AnimationPreferences(
                    duration: Duration(milliseconds: 1800),
                  ),
                  child: ModernAppTextField(
                    textInputType: TextInputType.phone,
                    hinttext: "+91 8597244620",
                  ),
                ),

                // ---------------- button ----------------
                const SizedBox(height: Sizes.dimen_32),
                _isEditable
                    ? FadeInUp(
                        preferences: AnimationPreferences(
                          duration: Duration(milliseconds: 2000),
                        ),
                        child: PrimaryButton(
                          text: ButtonNames.saveChanges,
                          onTap: () {
                            _toggleEdit();
                            debugPrint(
                              "$debuggerTagProfile: Save Changes tapped",
                            );
                          },
                        ),
                      )
                    : FadeInUp(
                        preferences: AnimationPreferences(
                          duration: Duration(milliseconds: 2000),
                        ),
                        child: TextButton(
                          onPressed: () {
                            _toggleEdit();
                            debugPrint("$debuggerTagProfile: Edit Now tapped");
                          },
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: Theme.of(context).textTheme.bodyMedium,
                              children: [
                                TextSpan(
                                  text: AppStringConstants
                                      .doYouWantToEditYourProfile,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: AppStringConstants.editNow,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.primaryActionColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(height: Sizes.dimen_16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
