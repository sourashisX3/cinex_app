import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

///Used by [SlitOutHorizontal] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class SlitOutHorizontalAnimation extends AnimationDefinition {
  SlitOutHorizontalAnimation({
    super.preferences =
        const AnimationPreferences(duration: Duration(milliseconds: 750)),
  });

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return FadeTransition(
      opacity: animator.get('opacity') as Animation<double>,
      child: AnimatedBuilder(
        animation: animator.controller!,
        child: child,
        builder: (BuildContext context, Widget? child) => Transform(
          transform: Perspective.matrix(1.5) *
              Matrix4.translationValues(
                  0.0, 0.0, animator.get("translateZ")!.value) *
              Matrix4.rotationX(
                animator.get('rotateX')!.value,
              ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    return {
      'opacity': TweenList<double>(
        [
          const TweenPercentage(percent: 54, value: 1.0),
          const TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
      'translateZ': TweenList<double>(
        [
          const TweenPercentage(percent: 0, value: 0.0),
          TweenPercentage(percent: 54, value: 160.0 * preferences.magnitude),
          TweenPercentage(percent: 100, value: 800.0 * preferences.magnitude),
        ],
      ),
      'rotateX': TweenList<double>(
        [
          const TweenPercentage(percent: 0, value: 0.0),
          TweenPercentage(
              percent: 54, value: -87.0 * toRad * preferences.magnitude),
          TweenPercentage(
              percent: 100, value: -90.0 * toRad * preferences.magnitude),
        ],
      ),
    };
  }
}

/// Example of using SlitOutHorizontal:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return SlitOutHorizontal(child: Text('Bounce'));
///   }
///
/// }
/// ```
class SlitOutHorizontal extends AnimatorWidget {
  SlitOutHorizontal({
    super.key,
    required super.child,
    AnimationPreferences preferences =
        const AnimationPreferences(duration: Duration(milliseconds: 750)),
  }) : super(
            definition: SlitOutHorizontalAnimation(preferences: preferences));
}
