import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ShakeGame extends StatefulWidget {
  @override
  _ShakeGameState createState() => _ShakeGameState();
}

class _ShakeGameState extends State<ShakeGame> {
  static const int targetShakes = 10;
  static const int maxScore = 1000;
  static const double obstacleFrequency =
      0.2; // 20% chance of an obstacle appearing
  static const double obstacleSpeed = 10; // pixels per second

  int _currentShakes = 0;
  int _currentScore = 0;
  List<Obstacle> _obstacles = [];

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (event.x.abs() > 15 || event.y.abs() > 15 || event.z.abs() > 15) {
        _incrementShake();
      }
    });

    // Start the obstacle timer
    Timer.periodic(Duration(milliseconds: 100), (_) {
      if (Random().nextDouble() < obstacleFrequency) {
        setState(() {
          _obstacles.add(Obstacle());
        });
      }

      // Move the obstacles
      _obstacles.forEach((obstacle) => obstacle.move());

      // Check for collisions with obstacles
      if (_obstacles.any((obstacle) => obstacle.collidesWithPlayer())) {
        _endGame();
      }

      // Remove off-screen obstacles
      _obstacles.removeWhere((obstacle) => obstacle.isOffScreen());
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _incrementShake() {
    setState(() {
      _currentShakes++;
      if (_currentShakes == targetShakes) {
        _endGame();
      }
    });
  }

  void _endGame() {
    double accuracy = _currentShakes / targetShakes;
    int score = (accuracy * maxScore).toInt();
    setState(() {
      _currentScore = score;
      _obstacles.clear();
    });
  }

  void _reset() {
    setState(() {
      _currentShakes = 0;
      _currentScore = 0;
      _obstacles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shake Game'),
      ),
      body: Stack(
        children: [
          Player(),
          ..._obstacles,
        ],
      ),
      bottomSheet: Container(
        color: Colors.grey[300],
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Shakes: $_currentShakes',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Score: $_currentScore',
              style: TextStyle(fontSize: 24),
            ),
            ElevatedButton(
              child: Text('Reset'),
              onPressed: _reset,
            ),
          ],
        ),
      ),
    );
  }
}

class Player extends StatefulWidget {
  static const double playerSize = 50;
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double _playerPosition = 0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        _playerPosition -= event.y * 10;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: _playerPosition,
      left: MediaQuery.of(context).size.width / 2 - Player.playerSize / 2,
      child: Container(
        width: Player.playerSize,
        height: Player.playerSize,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class Obstacle extends StatelessWidget {
  static const double obstacleSize = 50;
  double _obstaclePosition = 0;
  double obstacleSpeed = 10;

  Obstacle() {
    _obstaclePosition = -obstacleSize;
  }

  void move() {
    _obstaclePosition += obstacleSpeed / 10;
  }

  bool isOffScreen() {
    return _obstaclePosition >
        MediaQueryData.fromWindow(WidgetsBinding.instance!.window).size.height;
  }

  bool collidesWithPlayer() {
    double playerPosition = _PlayerState()._playerPosition;
    return _obstaclePosition + obstacleSize > playerPosition &&
        _obstaclePosition < playerPosition + Player.playerSize;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: _obstaclePosition,
      left: Random().nextDouble() *
          (MediaQuery.of(context).size.width - obstacleSize),
      child: Container(
        width: obstacleSize,
        height: obstacleSize,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ShakeGame(),
  ));
}
