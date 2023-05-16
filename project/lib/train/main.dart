import 'package:flutter/material.dart';
import '../Jeux1/train.dart';
import '../Jeux2/train.dart';
import '../Jeux3/train.dart';
import '../Jeux4/training.dart';
import '../Jeux5/training.dart';
import '../Jeux6/train.dart';
import '../main.dart';
import '../Elements/index.dart';


class Training extends StatelessWidget {
  const Training({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
                    MaterialPageRoute(builder: (context) => const StartPage()),
                  );
                },
              ),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Projet ProgM'))
            ],
          )),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/fond.png'),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: const EdgeInsets.only(left: 60.0, right: 60.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    bouton('Quiz', context, Jeux1Train()),
                    bouton('Devine le pays', context, Jeux2Train()),
                    bouton('Shaker', context, ShakeGameTrain()),
                    bouton('Spammer écran', context, Jeux4Train()),
                    bouton('Labyrinthe', context, MazeGameTrain()),
                    bouton('Memory', context, MemoryGameTrain())
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}
