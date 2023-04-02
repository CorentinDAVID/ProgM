import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Map<String, String> _questionsAndAnswers = {
    'Quelle est la capitale de la France?': 'Paris',
    'Quelle est la couleur du cheval blanc d\'Henri IV?': 'Blanc',
    'Quel est le fruit préféré de George Washington?': 'Cerise',
  };

  String _currentQuestion = '';
  List<String> _currentAnswers = [];
  String _correctAnswer = '';
  bool _answerIsCorrect = false;
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _pickRandomQuestion();
  }

  void _pickRandomQuestion() {
    var rng = Random();
    var keys = _questionsAndAnswers.keys.toList();
    var randomKey = keys[rng.nextInt(keys.length)];
    _currentQuestion = randomKey;
    _correctAnswer = _questionsAndAnswers[randomKey]!;
    _currentAnswers = _shuffleAnswers(_questionsAndAnswers.values.toList());
  }

  List<String> _shuffleAnswers(List<String> answers) {
    var rng = Random();
    for (var i = answers.length - 1; i > 0; i--) {
      var j = rng.nextInt(i + 1);
      var temp = answers[i];
      answers[i] = answers[j];
      answers[j] = temp;
    }
    return answers;
  }

  void _checkAnswer(String selectedAnswer) {
    if (selectedAnswer == _correctAnswer) {
      setState(() {
        _answerIsCorrect = true;
        _score++;
      });
    } else {
      setState(() {
        _answerIsCorrect = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                'Score: $_score',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentQuestion,
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Column(
              children: _currentAnswers.map((answer) {
                return GestureDetector(
                  onTap: () => _checkAnswer(answer),
                  child: Container(
                    color: answer == _correctAnswer
                        ? (_answerIsCorrect ? Colors.green : Colors.white)
                        : (_answerIsCorrect && answer != _correctAnswer
                            ? Colors.red
                            : Colors.white),
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      answer,
                      style: TextStyle(
                        fontSize: _answerIsCorrect && answer == _correctAnswer
                            ? 20.0
                            : 16.0,
                        color: answer == _correctAnswer
                            ? (_answerIsCorrect ? Colors.white : Colors.black)
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  _pickRandomQuestion();
                  _answerIsCorrect = false;
                });
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  'Next Question',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: () {
                setState(() {
                  _score = 0;
                  _answerIsCorrect = false;
                });
              },
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  'Reset Score',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
