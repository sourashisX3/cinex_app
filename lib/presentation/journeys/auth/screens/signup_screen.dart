import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:cinex_app/common/constants/strings/app_string_constants.dart';
import 'package:cinex_app/common/constants/strings/debugger_tags.dart';
import 'package:cinex_app/common/extensions/validation_functions.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_cubit.dart';
import 'package:cinex_app/presentation/journeys/auth/bloc/auth_states.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/animation/animation_preferences.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/widgets/fading_entrances/fade_in_down.dart';
import 'package:cinex_app/presentation/libraries/AppContents/flutter_animator/widgets/fading_entrances/fade_in_up.dart';
import 'package:cinex_app/presentation/themes/app_color.dart';
import 'package:cinex_app/presentation/themes/font_family_constants.dart';
import 'package:cinex_app/presentation/widgets/Buttons/primary_button.dart';
import 'package:cinex_app/presentation/widgets/TextFields/modern_app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  final void Function()? toggleScreens;
  const SignupScreen({super.key, this.toggleScreens});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword1 = true;
  bool _obscurePassword2 = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Error state for form fields
  String? _nameError;
  String? _phoneError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  // sign up
  void _signUp() {
    setState(() {
      _nameError = null;
      _phoneError = null;
      _emailError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    final String name = _fullNameController.text.trim();
    final String phone = _phoneNumberController.text.trim();
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    // Debug logging
    debugPrint("$debuggerTagSignUp SignupScreen._signUp called with:");
    debugPrint("$debuggerTagSignUp  Name: '$name'");
    debugPrint("$debuggerTagSignUp  Phone: '$phone'");
    debugPrint("$debuggerTagSignUp  Email: '$email'");
    debugPrint("$debuggerTagSignUp  Password length: ${password.length}");
    debugPrint(
      "$debuggerTagSignUp  Confirm Password length: ${confirmPassword.length}",
    );

    bool hasValidationErrors = false;

    if (isFieldEmpty(name)) {
      setState(() {
        _nameError = "Full name is required";
      });
      hasValidationErrors = true;
    } else if (!isValidName(name)) {
      setState(() {
        _nameError = "Name must be at least 2 characters long";
      });
      hasValidationErrors = true;
    }

    if (isFieldEmpty(phone)) {
      setState(() {
        _phoneError = "Phone number is required";
      });
      hasValidationErrors = true;
    } else if (!isValidPhoneNumber(phone)) {
      setState(() {
        _phoneError = "Please enter a valid phone number";
      });
      hasValidationErrors = true;
    }

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
    } else if (!isValidPassword(password)) {
      setState(() {
        _passwordError = "Password must be at least 6 characters long";
      });
      hasValidationErrors = true;
    }

    if (isFieldEmpty(confirmPassword)) {
      setState(() {
        _confirmPasswordError = "Please confirm your password";
      });
      hasValidationErrors = true;
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match. Please check and try again."),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
      hasValidationErrors = true;
    }
    if (hasValidationErrors) {
      return;
    }
    debugPrint(
      "$debuggerTagSignUp All UI validation passed. Calling authCubit.signUp...",
    );
    final authCubit = context.read<AuthCubit>();
    authCubit.signUp(name, phone, email, password);
  }

  void _togglePassword1Visibility() {
    setState(() {
      _obscurePassword1 = !_obscurePassword1;
    });
  }

  void _togglePassword2Visibility() {
    setState(() {
      _obscurePassword2 = !_obscurePassword2;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _confirmPasswordController.dispose();
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
        } else if (state is Authenticated) {
          widget.toggleScreens?.call();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Account created successfully! Please login."),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
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
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 400),
                      ),
                      child: Text(
                        AppStringConstants.signUp,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    FadeInDown(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 600),
                      ),
                      child: Text(
                        AppStringConstants.newUserMessage,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColor.primaryActionColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_32),

                    ///----------------- Text Fields -----------------
                    // -----------------[ full name ]----------------
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 800),
                      ),
                      child: Text(
                        AppStringConstants.fullName,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: FontFamilyConstants.zalandoSansBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_8),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 900),
                      ),
                      child: ModernAppTextField(
                        prefixIcon: const Icon(Icons.person),
                        textEditingController: _fullNameController,
                        hasPrefixWithPadding: true,
                        textInputType: TextInputType.name,
                        hinttext: AppStringConstants.enterFullName,
                        errorText: _nameError,
                      ),
                    ),
                    // -----------------[ phone number ]----------------
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1000),
                      ),
                      child: Text(
                        AppStringConstants.phoneNumber,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: FontFamilyConstants.zalandoSansBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_8),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1100),
                      ),
                      child: ModernAppTextField(
                        prefixIcon: const Icon(Icons.phone),
                        textEditingController: _phoneNumberController,
                        hasPrefixWithPadding: true,
                        textInputType: TextInputType.number,
                        hinttext: AppStringConstants.enterPhoneNumber,
                        errorText: _phoneError,
                      ),
                    ),
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
                        duration: Duration(milliseconds: 1300),
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
                        duration: Duration(milliseconds: 1400),
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
                        duration: Duration(milliseconds: 1500),
                      ),
                      child: ModernAppTextField(
                        prefixIcon: const Icon(Icons.lock),
                        textEditingController: _passwordController,
                        hasPrefixWithPadding: true,
                        textInputType: TextInputType.visiblePassword,
                        hinttext: AppStringConstants.enterPassword,
                        passwordVisible: _obscurePassword1,
                        errorText: _passwordError,
                        suffixIcon: GestureDetector(
                          onTap: _togglePassword1Visibility,
                          child: Icon(
                            _obscurePassword1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                      ),
                    ),
                    // ----------------[ confirm password ]----------------
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1600),
                      ),
                      child: Text(
                        AppStringConstants.confirmPassword,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontFamily: FontFamilyConstants.zalandoSansBold,
                        ),
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_8),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1700),
                      ),
                      child: ModernAppTextField(
                        prefixIcon: const Icon(Icons.lock),
                        textEditingController: _confirmPasswordController,
                        hasPrefixWithPadding: true,
                        textInputType: TextInputType.visiblePassword,
                        hinttext: AppStringConstants.enterConfirmPassword,
                        passwordVisible: _obscurePassword2,
                        errorText: _confirmPasswordError,
                        suffixIcon: GestureDetector(
                          onTap: _togglePassword2Visibility,
                          child: Icon(
                            _obscurePassword2
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
                        duration: Duration(milliseconds: 1800),
                      ),
                      child: PrimaryButton(
                        text: AppStringConstants.signUp,
                        onTap: () {
                          if (state is! AuthLoading) {
                            _signUp();
                            debugPrint("$debuggerTagSignUp: Signup tapped");
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: Sizes.dimen_16),
                    FadeInUp(
                      preferences: AnimationPreferences(
                        duration: Duration(milliseconds: 1900),
                      ),
                      child: Row(
                        children: [
                          Text(
                            AppStringConstants.existingUserMessage,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          TextButton(
                            onPressed: () {
                              widget.toggleScreens?.call();
                              debugPrint("$debuggerTagSignUp: Login Up tapped");
                            },
                            child: Text(
                              AppStringConstants.login,
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
