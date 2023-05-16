import 'package:flutter/material.dart';
import 'package:project/Jeux4/training.dart';
import 'package:project/solo/gestion.dart';
import '../main.dart';
import '../Elements/index.dart';
import '../Jeux3/main.dart';
import 'package:audioplayers/audioplayers.dart';


class Lose extends StatelessWidget {
  const Lose({super.key});
  

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
                    Text('YOU LOSE',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.red, fontSize: 70, fontFamily: 'Lobster')),
                    Text('You have only completed ${nbManche-1} out of 3 rounds',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.white, fontSize: 45, fontFamily: 'Lobster'))
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}


