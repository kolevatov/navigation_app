import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBox extends StatefulWidget {
  const AnimatedBox({Key? key}) : super(key: key);

  @override
  State<AnimatedBox> createState() => _AnimatedBoxState();
}

class _AnimatedBoxState extends State<AnimatedBox> {
  final _duration = const Duration(milliseconds: 500);
  late double _borderRadius;
  late double _margin;
  late Color _color;

  void _animateBox() {
    setState(() {
      _borderRadius = _randomBorderRadius();
      _margin = _randomMargin();
      _color = _randomColor();
    });
  }

  double _randomBorderRadius() {
    return Random().nextDouble() * 64;
  }

  double _randomMargin() {
    return Random().nextDouble() * 64;
  }

  Color _randomColor() {
    return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
  }

  @override
  void initState() {
    _borderRadius = _randomBorderRadius();
    _margin = _randomMargin();
    _color = _randomColor();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Box'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Tap here!'),
        backgroundColor: Colors.green,
        onPressed: () => _animateBox(),
      ),
      body: Center(
        child: SizedBox(
          height: 256,
          width: 256,
          child: AnimatedContainer(
            duration: _duration,
            curve: Curves.bounceIn,
            margin: EdgeInsets.all(_margin),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(_borderRadius),
            ),
          ),
        ),
      ),
    );
  }
}
