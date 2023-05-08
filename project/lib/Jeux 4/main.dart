import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiver/async.dart';
import 'dart:math';

class Jeux4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _gameStarted = false;
  bool _gameOver = false;
  int _timeRemaining = 60;
  late CountdownTimer _countdownTimer;
  Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: _timeRemaining),
    )..addListener(() {
        if (_controller.isCompleted) {
          setState(() {
            _gameOver = true;
          });
        }
      });

    _countdownTimer = CountdownTimer(
      Duration(seconds: _timeRemaining),
      Duration(seconds: 1),
    );
    _countdownTimer.listen((timer) {
      setState(() {
        _timeRemaining = timer.remaining.inSeconds;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    if (!_gameStarted && !_gameOver) {
      _startGame();
    }
    if (_gameStarted && !_gameOver) {
      _controller.stop();
      setState(() {
        _gameOver = true;
      });
    }
  }

  void _handleTapUp(_) {
    if (_gameStarted && !_gameOver) {
      _controller.stop();
      setState(() {
        _gameOver = true;
      });
    }
  }

  void _startGame() {
    setState(() {
      _gameStarted = true;
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        child: Stack(
          children: [
            if (_gameStarted)
              Positioned(
                top:  _random.nextDouble() * MediaQuery.of(context).size.width,
                left:  _random.nextDouble() * MediaQuery.of(context).size.height,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.translate(
                      offset: Offset(0, _controller.value * MediaQuery.of(context).size.height),
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTapDown: _handleTapDown,
                    onTapUp: _handleTapUp,
                    child: Image.asset('images/car.png'),
                  ),
                ),
              ),
            if (!_gameStarted)
              Center(
                child: Text(
                  'Appuyez pour commencer',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            Positioned(
              top: 16,
              left: 16,
              child: Text(
                'Temps restant : $_timeRemaining s',
                style: TextStyle(fontSize: 18),
              ),
            ),
            if (_gameOver)
              Center(
                child: Text(
                  'Game Over',
                  style: TextStyle(fontSize: 24),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
