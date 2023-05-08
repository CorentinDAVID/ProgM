import 'package:flutter/material.dart';
import 'package:project/Jeux%204/main.dart';
import '../main.dart';
import '../Elements/index.dart';
import '../Jeux 3/main.dart';

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
                    bouton('Défi 1', context, null),
                    bouton('Défi 2', context, null),
                    bouton('Défi 3', context, Jeux3()),
                    bouton('Défi 4', context, Jeux4())
                  ],
                ))
          ],
        ),
      ),
    ));
  }
}


