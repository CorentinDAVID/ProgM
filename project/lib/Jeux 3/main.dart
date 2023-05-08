import 'package:flutter/material.dart';
import 'package:project/train/main.dart';
import '../main.dart';
import '../Elements/index.dart';
import 'package:sensors_plus/sensors_plus.dart';

class Jeux3 extends StatefulWidget {
  @override
  _Jeux3State createState() => _Jeux3State();
}

class _Jeux3State extends State<Jeux3> {
  double _height = 0.0;

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event) {
      setState(() {
        // La hauteur est calculée en utilisant l'accélération de la gravité mesurée par l'accéléromètre
        _height = event.z * 9.81;
      });
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
        child: Text('Hauteur: ${_height.toStringAsFixed(2)} m')
      ),
    );
  }
}
