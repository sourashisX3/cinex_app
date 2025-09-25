import 'package:cinex_app/presentation/journeys/auth/screens/login_screen.dart';
import 'package:cinex_app/presentation/journeys/auth/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthScreen> {
  // initially show login 
  bool showLoginScreen = true;

  // toggle between login and signup 
  void toggleScreens() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(toggleScreens: toggleScreens);
    } else {
      return SignupScreen(toggleScreens: toggleScreens);
    }
  }
}
