import 'package:flutter/material.dart';
import '../main.dart';
import '../Elements/index.dart';

class Jeux3 extends StatefulWidget {
  @override
  _Jeux3State createState() => _Jeux3State();
}

class _Jeux3State extends State<Jeux3> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  List<Widget> _images = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(0, 1),
    ).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          _controller.forward();
          setState(() {
            _images.removeAt(0);
          });
        }
      });
    _controller.forward();
    _images.add(
      Image.asset(
        'images/car.png',
        width: 100,
        height: 100,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _images,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


