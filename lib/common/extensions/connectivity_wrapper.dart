import 'package:cinex_app/data/bloc/internet_connectivity_bloc/internet_bloc.dart';
import 'package:cinex_app/data/bloc/internet_connectivity_bloc/internet_state.dart';
import 'package:cinex_app/presentation/journeys/onboardings/screens/first_onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void _showTopOverlaySnackBar(
  BuildContext context, {
  required String message,
  required Color backgroundColor,
  required Duration duration,
}) {
  final overlay = Overlay.of(context);

  final double topPadding = MediaQuery.of(context).padding.top + 8.0;

  final overlayEntry = OverlayEntry(
    builder: (ctx) => Positioned(
      top: topPadding,
      left: 16.0,
      right: 16.0,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          bottom: false,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);

  Future.delayed(duration, () {
    try {
      overlayEntry.remove();
    } catch (_) {}
  });
}

class ConnectivityWrapper extends StatelessWidget {
  const ConnectivityWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, internetState) {
        if (internetState is InternetLostState) {
          _showTopOverlaySnackBar(
            context,
            message: 'No Internet Connection',
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          );
        } else if (internetState is InternetGainedState) {
          _showTopOverlaySnackBar(
            context,
            message: 'Internet Connected',
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          );
        }
      },
      child: const FirstOnboardingScreen(),
    );
  }
}
