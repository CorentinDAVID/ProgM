import 'package:flutter/material.dart';
import 'train/main.dart';
import 'Elements/index.dart';

void main() {
  runApp(const MaterialApp(
    title: 'Projet Prog',
    home: StartPage(),
  ));
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 18, 77, 126),
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [logo,
              Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Projet ProgM'))
            ],
          )),
      body: Container(
        decoration: wallpaper,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.all(10.0),
              alignment: Alignment.topLeft,
              child: alertBox("Game Rules", "Hello, you are in a fun game where you can play against your friends with the same wifi, to win the game you will have to pass different challenges.\n\nYou can also practice solo.\n\nHave fun!", context),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 150.0, top: 100.0),
              child: background_text,
            ),
            Container(
              margin: const EdgeInsets.only(left: 60.0, right: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  bouton('Play', context, null),
                  bouton('Training', context, const Training())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


var logo = Image.asset('images/ic_launcher.png', fit: BoxFit.contain, height: 32);

const wallpaper = BoxDecoration(image: DecorationImage(image: AssetImage('images/fond.png'), fit: BoxFit.cover,));

const background_text = Text('Play a game', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 70, fontFamily: 'Lobster'));