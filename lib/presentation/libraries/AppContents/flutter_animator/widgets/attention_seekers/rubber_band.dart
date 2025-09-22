/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020 Sjoerd van den Berg
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

///Used by [RubberBand] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class RubberBandAnimation extends AnimationDefinition {
  RubberBandAnimation({
    super.preferences,
  });

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller!,
      child: child,
      builder: (BuildContext context, Widget? child) => Transform(
        transform: animator.get("transform")!.value,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    final m = Matrix4.identity();
    return {
      "transform": TweenList<Matrix4>(
        [
          TweenPercentage(percent: 0, value: m),
          TweenPercentage(
              percent: 30,
              value: m.scaled(1.0 + 0.25 * preferences.magnitude,
                  1.0 - 0.25 * preferences.magnitude, 1.0)),
          TweenPercentage(
              percent: 40,
              value: m.scaled(1.0 - 0.25 * preferences.magnitude,
                  1.0 + 0.25 * preferences.magnitude, 1.0)),
          TweenPercentage(
              percent: 50,
              value: m.scaled(1.0 + 0.15 * preferences.magnitude,
                  1.0 - 0.15 * preferences.magnitude, 1.0)),
          TweenPercentage(
              percent: 65,
              value: m.scaled(1.0 - 0.05 * preferences.magnitude,
                  1.0 + 0.05 * preferences.magnitude, 1.0)),
          TweenPercentage(
              percent: 75,
              value: m.scaled(1.0 + 0.05 * preferences.magnitude,
                  1.0 - 0.05 * preferences.magnitude, 1.0)),
          TweenPercentage(percent: 100, value: m),
        ],
      ),
    };
  }
}

/// Example of using RubberBand:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return RubberBand(child: Text('Bounce'));
///   }
///
/// }
/// ```
class RubberBand extends AnimatorWidget {
  RubberBand({
    super.key,
    required super.child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            definition: RubberBandAnimation(preferences: preferences));
}
