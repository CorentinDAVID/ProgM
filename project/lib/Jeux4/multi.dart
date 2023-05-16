import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project/train/main.dart';
import '../main.dart';
import '../Elements/index.dart';

class Jeux4Multi extends StatefulWidget {
  @override
  _Jeux4MultiState createState() => _Jeux4MultiState();
}

class _Jeux4MultiState extends State<Jeux4Multi> {
  int _counter = 0;
  int _secondsRemaining = 20;
  late Timer _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer.cancel();
          addWinner("Joueur1");
          gestion(context);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 77, 126),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset(
                  'images/ic_launcher.png',
                  fit: BoxFit.contain,
                  height: 32,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Training()),
                  );
                },
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Projet ProgM'))
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _secondsRemaining > 0 ? _incrementCounter : null,
              child: Text('Tap Me!'),
            ),
            SizedBox(height: 20),
            Text(
              '$_secondsRemaining seconds remaining',
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _counter = 0;
          _secondsRemaining = 20;
          _startTimer();
        },
        tooltip: 'Start Game',
        child: Icon(Icons.play_arrow),
      ),
    );
  }
}
