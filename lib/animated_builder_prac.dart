import 'dart:math' show pi;

import 'package:flutter/material.dart';

class AnimatedBuilderPractice extends StatefulWidget {
  const AnimatedBuilderPractice({super.key});

  @override
  State<AnimatedBuilderPractice> createState() =>
      _AnimatedBuilderPracticeState();
}

/* 

0.0 = 0 degrees
0.5 = 180 degrees
1.0 = 360 degrees

*/

class _AnimatedBuilderPracticeState extends State<AnimatedBuilderPractice>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(); // or we can write _controller.repeat();

    _animation = Tween<double>(begin: 0.0, end: pi * 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AnimatedBuilder Practice')),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              // Matrix4.identity() is like telling Offset.zero basically reset any previous transforms and rotate it by the given value
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 7,
                      spreadRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
