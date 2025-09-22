import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

///Used by [RollIn] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class RollInAnimation extends AnimationDefinition {
  RollInAnimation({
    super.preferences,
  }) : super(
          needsWidgetSize: true,
          preRenderOpacity: 0.0,
        );

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get("opacity") as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform(
          transform: Matrix4.translationValues(
                  animator.get("translateX")!.value, 0.0, 0.0) *
              Matrix4.rotationZ(animator.get("rotateZ")!.value),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    return {
      "opacity": TweenList<double>(
        [
          const TweenPercentage(percent: 0, value: 0.0),
          const TweenPercentage(percent: 100, value: 1.0),
        ],
      ),
      "translateX": TweenList<double>(
        [
          TweenPercentage(
              percent: 0, value: -widgetSize!.width * preferences.magnitude),
          const TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
      "rotateZ": TweenList<double>(
        [
          TweenPercentage(
              percent: 0, value: -120.0 * toRad * preferences.magnitude),
          const TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
    };
  }
}

/// Example of using RollIn:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return RollIn(child: Text('Bounce'));
///   }
///
/// }
/// ```
class RollIn extends AnimatorWidget {
  RollIn({
    super.key,
    required super.child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            definition: RollInAnimation(preferences: preferences));
}
