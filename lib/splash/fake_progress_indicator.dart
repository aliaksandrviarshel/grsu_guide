import 'package:flutter/material.dart';

class FakeLinearProgressIndicator extends StatefulWidget {
  final Duration duration;
  final Color color;
  final Color backgroundColor;
  final String semanticsLabel;
  final VoidCallback? onDone;
  final ProgressController? controller;

  const FakeLinearProgressIndicator({
    super.key,
    this.duration = const Duration(seconds: 3),
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
    this.semanticsLabel = 'Loading',
    this.onDone,
    this.controller,
  });

  @override
  State<FakeLinearProgressIndicator> createState() =>
      _FakeLinearProgressIndicatorState();
}

class _FakeLinearProgressIndicatorState
    extends State<FakeLinearProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  double _progressValue = 0.0;
  double _speedFactor = 1.0;
  bool _stopAtEightyPercent = true;

  void speedUp() {
    _speedFactor *= 3.0;
    _animationController.duration = Duration(
        milliseconds: (widget.duration.inMilliseconds ~/ _speedFactor).round());
    _stopAtEightyPercent = false;
    _animationController.forward();
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.attach(this);
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {
          if (_stopAtEightyPercent && _animationController.value >= 0.8) {
            _animationController.stop();
          } else {
            _progressValue = _animationController.value;
            if (_progressValue == 1.0 && widget.onDone != null) {
              widget.onDone!();
            }
          }
        });
      });
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: _animationController.duration!,
      builder: (BuildContext context, double value, Widget? child) {
        return LinearProgressIndicator(
          value: _progressValue,
          valueColor: AlwaysStoppedAnimation<Color>(widget.color),
          backgroundColor: widget.backgroundColor,
          semanticsLabel: widget.semanticsLabel,
        );
      },
    );
  }
}

class ProgressController {
  late final _FakeLinearProgressIndicatorState _state;

  void attach(_FakeLinearProgressIndicatorState state) {
    _state = state;
  }

  void speedUp() {
    _state.speedUp();
  }
}
