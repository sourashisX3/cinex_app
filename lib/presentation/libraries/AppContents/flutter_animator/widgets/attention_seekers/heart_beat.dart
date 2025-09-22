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

///Used by [HeartBeat] widget.
///Note: You can also pass this into an [InOutAnimation] widget to define the
///in/out animation.
class HeartBeatAnimation extends AnimationDefinition {
  HeartBeatAnimation({
    super.preferences,
  });

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller!,
      child: child,
      builder: (BuildContext context, Widget? child) => Transform.scale(
        scale: animator.get("scale")!.value,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }

  @override
  Map<String, TweenList> getDefinition({Size? screenSize, Size? widgetSize}) {
    const curve = Curves.easeInOut;
    return {
      "scale": TweenList<double>(
        [
          const TweenPercentage(percent: 0, value: 1.0, curve: curve),
          TweenPercentage(
              percent: 14,
              value: 1.0 + 0.3 * preferences.magnitude,
              curve: curve),
          const TweenPercentage(percent: 28, value: 1.0, curve: curve),
          TweenPercentage(
              percent: 42,
              value: 1.0 + 0.3 * preferences.magnitude,
              curve: curve),
          const TweenPercentage(percent: 70, value: 1.0, curve: curve),
        ],
      ),
    };
  }
}

/// Example of using HeartBeat:
///
/// ```dart
/// class ExampleWidget extends StatelessWidget {
///
///   @override
///   Widget build(BuildContext context) {
///     return HeartBeat(child: Text('Bounce'));
///   }
///
/// }
/// ```
class HeartBeat extends AnimatorWidget {
  HeartBeat({
    super.key,
    required super.child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
            definition: HeartBeatAnimation(preferences: preferences));
}
