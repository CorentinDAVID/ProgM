import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:math';

class MazeGame extends StatefulWidget {
  @override
  _MazeGameState createState() => _MazeGameState();
}

class _MazeGameState extends State<MazeGame> {
  double ballX = 0.0;
  double ballY = 0.0;
  double mazeWidth = 300.0;
  double mazeHeight = 500.0;
  double exitSize = 50.0;
  double obstacleSize = 100.0;
  int lives = 3;
  bool gameFinished = false;

  // Déclaration des variables des obstacles
  Random random = Random();
  double obstacle1X = 700.0;
  double obstacle1Y = 500.0;
  double obstacle2X = 200.0;
  double obstacle2Y = 300.0;
  double obstacle3X = 150.0;
  double obstacle3Y = 400.0;
  double obstacle4X = 50.0;
  double obstacle4Y = 100.0;
  double obstacle5X = 250.0;
  double obstacle5Y = 200.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      if (!gameFinished) {
        setState(() {
          ballX += event.x * 2;
          ballY -= event.y * 2;
          checkCollision();
        });
      }
    });
    generateObstacles();
  }

  void generateObstacles() {
    Random random = Random();
    List<double> obstacleXList = [];
    List<double> obstacleYList = [];

    for (int i = 0; i < 5; i++) {
      double obstacleX = 0.0;
      double obstacleY = 0.0;
      bool isOverlapping = true;

      while (isOverlapping) {
        obstacleX = random.nextDouble() * (mazeWidth - obstacleSize);
        obstacleY = random.nextDouble() * (mazeHeight - obstacleSize);

        isOverlapping = false;

        for (int j = 0; j < i; j++) {
          double distanceX = (obstacleXList[j] - obstacleX).abs();
          double distanceY = (obstacleYList[j] - obstacleY).abs();

          if (distanceX < obstacleSize && distanceY < obstacleSize) {
            isOverlapping = true;
            break;
          }
        }
      }

      obstacleXList.add(obstacleX);
      obstacleYList.add(obstacleY);
    }

    obstacle1X = obstacleXList[0];
    obstacle1Y = obstacleYList[0];
    obstacle2X = obstacleXList[1];
    obstacle2Y = obstacleYList[1];
    obstacle3X = obstacleXList[2];
    obstacle3Y = obstacleYList[2];
    obstacle4X = obstacleXList[3];
    obstacle4Y = obstacleYList[3];
    obstacle5X = obstacleXList[4];
    obstacle5Y = obstacleYList[4];
  }

  void checkCollision() {
    // Vérifie la collision avec les bords du labyrinthe
    if (ballX < 0) {
      ballX = 0;
    } else if (ballX > mazeWidth) {
      ballX = mazeWidth;
    }
    if (ballY < 0) {
      ballY = 0;
    } else if (ballY > mazeHeight) {
      ballY = mazeHeight;
    }

    // Vérifie la collision avec l'objectif de sortie
    if (ballX >= mazeWidth - exitSize && ballY >= mazeHeight - exitSize) {
      setState(() {
        gameFinished = true;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Félicitations !'),
            content: Text('Vous avez atteint la sortie du labyrinthe.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    if (ballX + 20 >= obstacle1X &&
        ballX <= obstacle1X + obstacleSize &&
        ballY + 20 >= obstacle1Y &&
        ballY <= obstacle1Y + obstacleSize) {
      // Collision avec l'obstacle 1
      setState(() {
        lives--;
        if (lives == 0) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Text('Vous avez été éliminé. Vies restantes : $lives'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }

    if (ballX + 20 >= obstacle2X &&
        ballX <= obstacle2X + obstacleSize &&
        ballY + 20 >= obstacle2Y &&
        ballY <= obstacle2Y + obstacleSize) {
      // Collision avec l'obstacle 2
      setState(() {
        lives--;
        if (lives == 0) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Text('Vous avez été éliminé. Vies restantes : $lives'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }

    if (ballX + 20 >= obstacle3X &&
        ballX <= obstacle3X + obstacleSize &&
        ballY + 20 >= obstacle3Y &&
        ballY <= obstacle3Y + obstacleSize) {
      // Collision avec l'obstacle 3
      setState(() {
        lives--;
        if (lives == 0) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Text('Vous avez été éliminé. Vies restantes : $lives'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }

    if (ballX + 20 >= obstacle4X &&
        ballX <= obstacle4X + obstacleSize &&
        ballY + 20 >= obstacle4Y &&
        ballY <= obstacle4Y + obstacleSize) {
      // Collision avec l'obstacle 4
      setState(() {
        lives--;
        if (lives == 0) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Text('Vous avez été éliminé. Vies restantes : $lives'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }

    if (ballX + 20 >= obstacle5X &&
        ballX <= obstacle5X + obstacleSize &&
        ballY + 20 >= obstacle5Y &&
        ballY <= obstacle5Y + obstacleSize) {
      // Collision avec l'obstacle 5
      setState(() {
        lives--;
        if (lives == 0) {
          gameFinished = true;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Game Over'),
                content: Text('Vous avez été éliminé. Vies restantes : $lives'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maze Game'),
        ),
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
              ),
            ),
            Positioned(
              left: ballX,
              top: ballY,
              child: Container(
                width: 20.0,
                height: 20.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              left: mazeWidth - exitSize,
              top: mazeHeight - exitSize,
              child: Container(
                width: exitSize,
                height: exitSize,
                decoration: BoxDecoration(
                  color: Colors.green,
                ),
              ),
            ),
            // Dessinez les obstacles ici
            Positioned(
              left: obstacle1X,
              top: obstacle1Y,
              child: Container(
                width: obstacleSize,
                height: obstacleSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              left: obstacle2X,
              top: obstacle2Y,
              child: Container(
                width: obstacleSize,
                height: obstacleSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              left: obstacle3X,
              top: obstacle3Y,
              child: Container(
                width: obstacleSize,
                height: obstacleSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              left: obstacle4X,
              top: obstacle4Y,
              child: Container(
                width: obstacleSize,
                height: obstacleSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              left: obstacle5X,
              top: obstacle5Y,
              child: Container(
                width: obstacleSize,
                height: obstacleSize,
                decoration: BoxDecoration(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
