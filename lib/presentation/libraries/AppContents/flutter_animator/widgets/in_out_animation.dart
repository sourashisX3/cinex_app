import 'package:flutter/widgets.dart';

import '../animation/animation_definition.dart';
import 'animator_widget.dart';

enum InOutAnimationStatus {
  None,
  In,
  Out,
}

class InOutAnimation extends StatefulWidget {
  final Widget child;
  final AnimationDefinition inDefinition;
  final AnimationDefinition outDefinition;

  final InOutAnimationStatus autoPlay;

  const InOutAnimation({
    super.key,
    required this.child,
    required this.inDefinition,
    required this.outDefinition,
    this.autoPlay = InOutAnimationStatus.In,
  });

  @override
  InOutAnimationState createState() => InOutAnimationState();
}

class InOutAnimationState extends State<InOutAnimation> {
  InOutAnimationStatus status = InOutAnimationStatus.None;

  GlobalKey<AnimatorWidgetState> inAnimation = GlobalKey<AnimatorWidgetState>();
  GlobalKey<AnimatorWidgetState> outAnimation = GlobalKey<AnimatorWidgetState>();

  @override
  void initState() {
    status = widget.autoPlay;
    super.initState();
  }

  void animateIn() {
    setState(() {
      status = InOutAnimationStatus.In;
    });
  }

  void animateOut() {
    setState(() {
      status = InOutAnimationStatus.Out;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case InOutAnimationStatus.In:
        return AnimatorWidget(
          key: inAnimation,
          definition: widget.inDefinition,
          child: widget.child,
        );
      case InOutAnimationStatus.Out:
        return AnimatorWidget(
          key: outAnimation,
          definition: widget.outDefinition,
          child: widget.child,
        );
      default:
        return widget.child;
    }
  }
}
