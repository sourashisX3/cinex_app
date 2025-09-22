import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import '../../flutter_animator.dart';

enum CrossFadePlayStatus { A, B }

class CrossFadeAB extends StatefulWidget {
  final Widget childA;
  final Widget childB;

  const CrossFadeAB({
    super.key,
    required this.childA,
    required this.childB,
  });

  @override
  CrossFadeABState createState() => CrossFadeABState();
}

class CrossFadeABState extends State<CrossFadeAB> implements TickerProvider {
  Animator? animatorA;
  Animator? animatorB;
  final List<Ticker> _tickers = [];
  CrossFadePlayStatus status = CrossFadePlayStatus.A;

  void cross() {
    switch (status) {
      case CrossFadePlayStatus.A:
        crossToB();
        break;
      case CrossFadePlayStatus.B:
        crossToA();
        break;
    }
  }

  void crossToA() {
    animatorA!.reverse();
    animatorB!.forward();
  }

  void crossToB() {
    animatorA!.forward();
    animatorB!.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        animatorA == null
            ? widget.childA
            : animatorA!.build(context, widget.childA),
        if (animatorB != null) animatorB!.build(context, widget.childB),
      ],
    );
  }

  void _createAnimators() {
    animatorA = Animator(vsync: this);
    animatorA!.setAnimationDefinition(
      FadeOutAnimation(
        preferences: AnimationPreferences(
          animationStatusListener: (AnimationStatus status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                this.status = CrossFadePlayStatus.B;
              });
            } else if (status == AnimationStatus.dismissed) {
              setState(() {
                this.status = CrossFadePlayStatus.A;
              });
            }
          },
        ),
      ),
    );
    animatorA!.resolveDefinition();

    animatorB = Animator(vsync: this);
    animatorB!.setAnimationDefinition(
      FadeOutAnimation(
        preferences: AnimationPreferences(),
      ),
    );
    animatorB!.resolveDefinition();
    animatorB!.reverse();
    animatorB!.stop();
  }

  @override
  void reassemble() {
    if (!kReleaseMode && mounted) {
      disposeExistingAnimation();
      setState(() {
        _createAnimators();
      });
    }
    super.reassemble();
  }

  @override
  void initState() {
    disposeExistingAnimation();
    _createAnimators();
    super.initState();
  }

  @override
  void dispose() {
    disposeExistingAnimation();
    super.dispose();
  }

  disposeExistingAnimation() {
    if (animatorA != null) {
      animatorA!.dispose();
    }
    if (animatorB != null) {
      animatorB!.dispose();
    }
    if (_tickers.isNotEmpty) {
      for (var ticker in _tickers) {
        ticker.dispose();
      }
      _tickers.clear();
    }
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    Ticker ticker =
        Ticker(onTick, debugLabel: kDebugMode ? 'created by $this' : null);
    _tickers.add(ticker);

    return ticker;
  }

  @override
  void didChangeDependencies() {
    for (var ticker in _tickers) {
      ticker.muted = !TickerMode.of(context);
    }
    super.didChangeDependencies();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    for (var ticker in _tickers) {
      String tickerDescription;
      if (ticker.isActive && ticker.muted) {
        tickerDescription = 'active but muted';
      } else if (ticker.isActive) {
        tickerDescription = 'active';
      } else if (ticker.muted) {
        tickerDescription = 'inactive and muted';
      } else {
        tickerDescription = 'inactive';
      }

      properties.add(DiagnosticsProperty<Ticker>('ticker', ticker,
          description: tickerDescription,
          showSeparator: false,
          defaultValue: null));
    }
  }
}
