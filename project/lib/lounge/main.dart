import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/Jeux3/main.dart';
import 'package:project/Jeux4/training.dart';
import '../main.dart';
import '../Elements/index.dart';

class Lounge extends StatelessWidget {
  const Lounge({super.key});

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
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => starGame()),
                        );
                      },
                      child: Text('Lets go !!'),
                    )
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}

StatefulWidget starGame(){
  List<dynamic> games = [];
  games.add(Jeux3());
  games.add(Jeux4());

  Random random = Random();

  int randomNumber = 0 + random.nextInt(games.length);

  print(randomNumber);

  return games[randomNumber];
}