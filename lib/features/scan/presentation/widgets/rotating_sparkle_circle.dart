import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RotatingSparkleCircle extends StatefulWidget {
  final double size;
  final Duration duration;

  const RotatingSparkleCircle({
    super.key,
    this.size = 30.0,
    this.duration = const Duration(seconds: 3),
  });

  @override
  State<RotatingSparkleCircle> createState() => _RotatingSparkleCircleState();
}

class _RotatingSparkleCircleState extends State<RotatingSparkleCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: SvgPicture.asset(
        'assets/imageSvg/ecosort_loading_spinner.svg', 
        height: widget.size,
        width: widget.size,
      ),
    );
  }
}
