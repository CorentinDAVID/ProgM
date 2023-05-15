import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Jeux1 extends StatelessWidget {
  const Jeux1({Key? key}) : super(key: key);

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
  static const int _totalQuestions = 10;
  static const int _timePerQuestion = 10; // En secondes

  final Map<String, String> _questionsAndAnswers = {
    'Quelle est la capitale de la France?': 'Paris',
    'Quelle est la couleur du cheval blanc d\'Henri IV?': 'Blanc',
    'Quel est le fruit préféré de George Washington?': 'Cerise',
    'Quelle est la plus haute montagne du monde?': 'Mont Everest',
    'Qui a peint la Joconde?': 'Leonardo da Vinci',
    'Quel est le plus grand océan du monde?': 'Océan Pacifique',
    'Quelle est la monnaie du Japon?': 'Yen',
    'Quel pays a remporté la Coupe du Monde de football 2018?': 'France',
    'Qui a écrit "Les Misérables"?': 'Victor Hugo',
    'Quel est le plus grand désert du monde?': 'Désert du Sahara',
    'Quelle est la date de la Déclaration d' 'Indépendance des États-Unis?':
        '4 juillet 1776',
    'Quel joueur de basketball a remporté le plus de titres NBA?':
        'Bill Russell',
    'Qui a découvert la gravité en observant une pomme tomber d' 'un arbre?':
        'Isaac Newton',
    'Quelle est la capitale de l' 'Australie?': 'Canberra',
    'Quel est le livre le plus vendu de tous les temps?': 'La Bible',
    'Quelle est la plus grande ville du Brésil?': 'São Paulo',
    'Qui a peint "La Nuit étoilée"?': 'Vincent van Gogh',
    'Quelle est la devise de la famille Stark dans "Game of Thrones"?':
        'L' 'hiver vient',
    'Quel est le nom du célèbre détective créé par Arthur Conan Doyle?':
        'Sherlock Holmes',
    'Quel est le symbole chimique de l' 'oxygène?': 'O',
    'Quelle est la distance approximative entre la Terre et le Soleil?':
        '149,6 millions de kilomètres',
    'Quel est le pays le plus peuplé du monde?': 'Chine',
    'Qui a écrit "1984"?': 'George Orwell',
    'Quelle est la devise de la France?': 'Liberté, Égalité, Fraternité',
    'Quel est le plus grand lac d' 'Afrique?': 'Lac Victoria',
    'Quel est le pays d' 'origine du groupe musical ABBA?': 'Suède',
    'Qui a écrit "Le Petit Prince"?': 'Antoine de Saint-Exupéry',
    'Quel est le symbole chimique du sodium?': 'Na',
    'Quelle est la vitesse de la lumière dans le vide?': '299 792 458 m/s',
    'Quel est le pays le plus vaste du monde?': 'Russie',
    'Quelle est la capitale de l\'Espagne?': 'Madrid',
    'Combien de planètes composent notre système solaire?': '8',
    'Quel est le plus grand fleuve d' 'Afrique?': 'Nil',
    'Qui a écrit "Hamlet"?': 'William Shakespeare',
    'Quelle est la monnaie du Royaume-Uni?': 'Livre sterling',
    'Quel est le pays le plus densément peuplé du monde?': 'Monaco',
    'Quel est le plus grand mammifère terrestre?': 'Éléphant',
    'Qui a peint "La Guernica"?': 'Pablo Picasso',
    'Quel est le symbole chimique du fer?': 'Fe',
    'Quelle est la distance entre la Terre et la Lune?': '384 400 km',
  };

  final List<String> _categories = [
    'Géographie',
    'Histoire',
    'Sport',
// Ajoutez plus de catégories ici...
  ];

  String _currentQuestion = '';
  String _correctAnswer = '';
  bool _answerIsCorrect = false;
  int _score = 0;
  int _questionCount = 0;
  Timer? _timer;
  int _remainingTime = _timePerQuestion;
  TextEditingController _textEditingController = TextEditingController();

  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _pickRandomQuestion();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  void _pickRandomQuestion() {
    if (_questionCount == _totalQuestions) {
// Toutes les questions ont été répondues, afficher le score
      _showScoreDialog();
      return;
    }

    var rng = Random();
    List<String> filteredQuestions = _questionsAndAnswers.keys.toList();

    if (_selectedCategory != null) {
      filteredQuestions = filteredQuestions.where((question) {
        return question
            .toLowerCase()
            .contains(_selectedCategory!.toLowerCase());
      }).toList();
    }

    if (filteredQuestions.isEmpty) {
      return; // Aucune question disponible pour la catégorie sélectionnée
    }

    String randomKey = filteredQuestions[rng.nextInt(filteredQuestions.length)];
    _currentQuestion = randomKey;
    _correctAnswer = _questionsAndAnswers[randomKey]!;

    _questionCount++;
    _resetTimer();
  }

  void _checkAnswer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    String userAnswer = _textEditingController.text;

    String userAnswerLower = userAnswer.toLowerCase();
    String correctAnswerLower = _correctAnswer.toLowerCase();

    if (userAnswer.toLowerCase() == _correctAnswer.toLowerCase()) {
      setState(() {
        _answerIsCorrect = true;
        _score++;
      });
    } else {
      setState(() {
        _answerIsCorrect = false;
      });
    }

// Attendre un court délai avant de passer à la prochaine question
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _pickRandomQuestion();
        _answerIsCorrect = false;
        _textEditingController.clear();
      });
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_remainingTime == 0) {
        timer.cancel();
        _checkAnswer(); // Considérer la réponse comme incorrecte lorsque le temps est écoulé
      } else {
        setState(() {
          _remainingTime--;
        });
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _remainingTime = _timePerQuestion;
    });
    _startTimer();
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Score'),
          content:
              Text('Vous avez obtenu $_score points sur $_totalQuestions.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Réponse',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: Text('Valider'),
            ),
            SizedBox(height: 16.0),
            Text(
              'Temps restant : $_remainingTime secondes',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
