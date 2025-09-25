import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/constants/strings/debugger_tags.dart';
import 'package:cinex_app/common/extensions/validation_functions.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_cubit.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_states.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/flutter_animator.dart';
import 'package:cinex_app/presentation/libraries/FlutterSizer/flutter_sizer.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:cinex_app/presentation/widgets/Buttons/primary_button.dart';
import 'package:cinex_app/presentation/widgets/TextFields/modern_app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  final void Function()? toggleScreens;
  const LoginScreen({super.key, this.toggleScreens});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailError;
  String? _passwordError;

  void _login() {
    setState(() {
      _emailError = null;
      _passwordError = null;
    });

    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // Debug logging
    debugPrint("$debuggerTagLogin LoginScreen._login called with:");
    debugPrint("$debuggerTagLogin  Email: '$email'");
    debugPrint("$debuggerTagLogin  Password length: ${password.length}");

    bool hasValidationErrors = false;

    if (isFieldEmpty(email)) {
      setState(() {
        _emailError = "Email address is required";
      });
      hasValidationErrors = true;
    } else if (!isValidEmail(email)) {
      setState(() {
        _emailError = "Please enter a valid email address";
      });
      hasValidationErrors = true;
    }
    if (isFieldEmpty(password)) {
      setState(() {
        _passwordError = "Password is required";
      });
      hasValidationErrors = true;
    }
    if (hasValidationErrors) {
      return;
    }
    debugPrint(
      "$debuggerTagLogin All UI validation passed. Calling authCubit.login...",
    );
    final authCubit = context.read<AuthCubit>();
    authCubit.login(email, password);
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: Sizes.paddingAll16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      child: Text(
                        AppStringConstants.login,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    FadeInDown(
                      child: Text(
                        AppStringConstants.welcomeMessage,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.primaryActionColor,
                        ),
                      ),
                    ),
                    SizedBox(height: Sizes.dimen_15.h),

                    ///----------------- Text Fields -----------------

                    // ----------------[ email ]----------------
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1200),
                      ),
                      child: Text(
                        AppStringConstants.emailAddress,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: FontFamilyConstants.zalandoSansBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_8),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1400),
                      ),
                      child: ModernAppTextField(
                        prefixIcon: const Icon(Icons.email),
                        textEditingController: _emailController,
                        hasPrefixWithPadding: true,
                        textInputType: TextInputType.emailAddress,
                        hinttext: AppStringConstants.enterEmail,
                        errorText: _emailError,
                      ),
                    ),
                    // ----------------[ password ]----------------
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1600),
                      ),
                      child: Text(
                        AppStringConstants.password,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: FontFamilyConstants.zalandoSansBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_8),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1800),
                      ),
                      child: ModernAppTextField(
                        prefixIcon: const Icon(Icons.lock),
                        textEditingController: _passwordController,
                        hasPrefixWithPadding: true,
                        textInputType: TextInputType.visiblePassword,
                        hinttext: AppStringConstants.enterPassword,
                        passwordVisible: _obscurePassword,
                        errorText: _passwordError,
                        suffixIcon: GestureDetector(
                          onTap: _togglePasswordVisibility,
                          child: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    // ---------------- button ----------------
                    const SizedBox(height: Sizes.dimen_32),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 2000),
                      ),
                      child: PrimaryButton(
                        text: AppStringConstants.login,
                        onTap: () {
                          if (state is! AuthLoading) {
                            _login();
                            debugPrint("$debuggerTagLogin: Login tapped");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 2200),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppStringConstants.dontHaveAnAccount,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggleScreens?.call();
                              debugPrint("$debuggerTagLogin: Sign Up tapped");
                            },
                            child: Text(
                              AppStringConstants.signUp,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColor.primaryActionColor,
                                    fontFamily:
                                        FontFamilyConstants.zalandoSansBold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
