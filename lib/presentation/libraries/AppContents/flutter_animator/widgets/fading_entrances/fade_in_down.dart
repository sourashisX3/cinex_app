
import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

///Used by [FadeInDown] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class FadeInDownAnimation extends AnimationDefinition {
  FadeInDownAnimation({
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
        builder: (BuildContext context, Widget? child) => Transform.translate(
          offset: Offset(0.0, animator.get("translateY")!.value),
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
      "translateY": TweenList<double>(
        [
          TweenPercentage(
              percent: 0, value: -widgetSize!.height * preferences.magnitude),
          const TweenPercentage(percent: 100, value: 0.0),
        ],
      ),
    };
  }
}

/// Example of using FadeInDown:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return FadeInDown(child: Text('Bounce'));
///   }
///
/// }
/// ```
class FadeInDown extends AnimatorWidget {
  FadeInDown({
    super.key,
    required super.child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            definition: FadeInDownAnimation(preferences: preferences));
}
