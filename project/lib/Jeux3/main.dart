import 'package:flutter/material.dart';
import 'package:project/solo/gestion.dart';
import 'package:sensors/sensors.dart';

void main() => runApp(ShakeGame());

class ShakeGame extends StatefulWidget {
  @override
  _ShakeGameState createState() => _ShakeGameState();
}

class _ShakeGameState extends State<ShakeGame> {
  static const int targetScore = 100;
  static const int minScore = 50;
  int currentScore = 0;
  int shakeCount = 0;
  bool isGameStarted = false;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (isGameStarted &&
          (event.x.abs() > 15 || event.y.abs() > 15 || event.z.abs() > 15)) {
        setState(() {
          shakeCount++;
          currentScore = shakeCount;
        });
      }
    });
  }

  void startGame() {
    setState(() {
      isGameStarted = true;
      shakeCount = 0;
      currentScore = 0;
      // Start a 10-second timer
      Future.delayed(Duration(seconds: 10), () {
        endGame();
      });
    });
  }

  void endGame() {
    mancheWin = currentScore == targetScore;
    gestion(context);
    setState(() {
      isGameStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Shake Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Score cible: $targetScore',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              if (!isGameStarted)
                ElevatedButton(
                  onPressed: startGame,
                  child: Text('Commencer'),
                ),
              if (isGameStarted)
                Text(
                  'Score: $currentScore',
                  style: TextStyle(fontSize: 24),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
