import 'package:flutter/material.dart';

class BouncyTapAnimation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool? isDisabled;

  const BouncyTapAnimation({
    super.key,
    required this.child,
    this.onTap,
    this.isDisabled = false,
  });

  @override
  State<BouncyTapAnimation> createState() => _BouncyTapAnimationState();
}

class _BouncyTapAnimationState extends State<BouncyTapAnimation> {
  double _scale = 1.0;

  Future<void> _triggerBounce() async {
    setState(() => _scale = 0.85);
    await Future.delayed(const Duration(milliseconds: 40));
    setState(() => _scale = 1.05);
    await Future.delayed(const Duration(milliseconds: 40));
    setState(() => _scale = 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.isDisabled!
            ? () {}
            : await _triggerBounce(); // Wait for the animation to complete
        widget.onTap?.call(); // Then call the tap callback
      },
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeOutBack,
        child: widget.child,
      ),
    );
  }
}
