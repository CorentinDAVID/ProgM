import 'package:flutter/material.dart';
import 'package:project/Jeux4/training.dart';
import '../main.dart';
import '../Elements/index.dart';
import '../Jeux3/main.dart';
import 'package:audioplayers/audioplayers.dart';

class Win extends StatefulWidget {
  @override
  _WinState createState() => _WinState();
}

class _WinState extends State<Win> {
  late AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    playMusic();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playMusic() async {
    await audioPlayer.play(DeviceFileSource('sounds/win.mp3'));
  }

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
                    Text('YOU WIN',
    textAlign: TextAlign.center,
    style: TextStyle(color: Colors.green, fontSize: 70, fontFamily: 'Lobster')),
                    Text('Congratulation',
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



