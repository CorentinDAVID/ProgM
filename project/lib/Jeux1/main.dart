import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _answerIsOk = false;

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: FractionalOffset.centerLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.wind_power,
                color:
                    _lightIsOn ? Color.fromARGB(255, 7, 204, 40) : Colors.black,
                size: 60,
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle light when tapped.
                  _lightIsOn = !_lightIsOn;
                });
              },
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(8),
                // Change button text when light changes state.
                child: Text(_lightIsOn ? 'Réponse correcte' : 'Réponse'),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: FractionalOffset.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Callback pour le premier bouton
                setState(() {
                  // Toggle light when tapped.
                  _answerIsOk = !_answerIsOk;
                });
              },
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.wind_power,
                  color: _answerIsOk
                      ? Color.fromARGB(255, 7, 204, 40)
                      : Colors.black,
                  size: 60,
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                // Callback pour le deuxième bouton
                setState(() {
                  // Toggle light when tapped.
                  _answerIsOk = !_answerIsOk;
                });
              },
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.wind_power,
                  color: _answerIsOk
                      ? Color.fromARGB(255, 7, 204, 40)
                      : Colors.black,
                  size: 60,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Callback pour le troisième bouton
                setState(() {
                  // Toggle light when tapped.
                  _answerIsOk = !_answerIsOk;
                });
              },
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(8),
                child: Icon(
                  Icons.wind_power,
                  color: _answerIsOk
                      ? Color.fromARGB(255, 7, 204, 40)
                      : Colors.black,
                  size: 60,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Callback pour le quatrième bouton
                setState(() {
                  // Toggle light when tapped.
                  _answerIsOk = !_answerIsOk;
                });
              },
              child: Container(
                color: Color.fromARGB(255, 255, 255, 255),
                padding: const EdgeInsets.all(8),
                child: Row(
                children: <Widget>[
                  Icon(Icons.star),
                  SizedBox(width: 8),
                  Text('Réponse 4'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
