import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MemoryGame(),
  ));
}

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> countries = [
    'USA',
    'Canada',
    'France',
    'Germany',
    'Italy',
    'Japan',
    'Russia',
    'Brazil',
    'China',
    'India',
  ];

  List<String> flags = [
    '🇺🇸',
    '🇨🇦',
    '🇫🇷',
    '🇩🇪',
    '🇮🇹',
    '🇯🇵',
    '🇷🇺',
    '🇧🇷',
    '🇨🇳',
    '🇮🇳',
  ];

  List<String> cards = [];
  List<bool> cardFlips = [];
  int attempts = 0;
  int matchedPairs = 0;
  int currentPlayer = 1;
  int player1Score = 0;
  int player2Score = 0;
  bool gameLocked = false;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    cards = [];
    cardFlips = [];
    attempts = 0;
    matchedPairs = 0;
    currentPlayer = 1;
    player1Score = 0;
    player2Score = 0;
    gameLocked = false;
    gameOver = false;

    // Create a list of cards by concatenating the countries and flags
    for (int i = 0; i < countries.length; i++) {
      cards.add(countries[i]);
      cards.add(flags[i]);
    }

    // Shuffle the cards
    cards.shuffle();

    // Initialize the card flip state to all false (cards facing down)
    cardFlips = List.generate(cards.length, (index) => false);
  }

  void onCardTap(int index) {
    if (gameLocked || cardFlips[index] || gameOver) {
      return;
    }

    setState(() {
      cardFlips[index] = true;
    });

    if (currentPlayer == 1) {
      checkCardMatch(index);
    } else {
      Timer(Duration(seconds: 1), () {
        checkCardMatch(index);
      });
    }
  }

  void checkCardMatch(int currentIndex) {
    int previous;
    int previousIndex = cards.indexWhere((card) =>
        cardFlips[cards.indexOf(card)] && card != cards[currentIndex]);

    if (previousIndex != -1) {
      // Match found
      if (cards[previousIndex] == cards[currentIndex]) {
        setState(() {
          if (currentPlayer == 1) {
            player1Score++;
          } else {
            player2Score++;
          }
          matchedPairs++;
          if (matchedPairs == countries.length) {
            gameOver = true;
          }
        });
      } else {
        // No match
        gameLocked = true;
        Timer(Duration(seconds: 1), () {
          setState(() {
            cardFlips[previousIndex] = false;
            cardFlips[currentIndex] = false;
            currentPlayer = currentPlayer == 1 ? 2 : 1;
            gameLocked = false;
          });
        });
      }
    } else {
      // First card selection
      if (currentPlayer == 2) {
        currentPlayer = 1;
      }
    }
  }

  void restartGame() {
    setState(() {
      initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Player 1 Score: $player1Score',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Player 2 Score: $player2Score',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: cards.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => onCardTap(index),
                  child: Card(
                    color: cardFlips[index] ? Colors.white : Colors.blue,
                    child: Center(
                      child: Text(
                        cardFlips[index] ? cards[index] : '',
                        style: TextStyle(
                          fontSize: 32,
                          color: cardFlips[index] ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (gameOver)
            ElevatedButton(
              onPressed: restartGame,
              child: Text('Restart Game'),
            ),
        ],
      ),
    );
  }
}
