import 'package:cinex_app/common/constants/size_constants.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: Sizes.paddingAll16,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(children: const [Text("Profile Screen")]),
          ),
        ),
      ),
    );
  }
}
