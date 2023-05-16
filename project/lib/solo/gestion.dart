import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/Jeux3/main.dart';
import 'package:project/Jeux4/multi.dart';
import 'package:project/Jeux4/training.dart';
import 'package:project/wifi/resultat.dart';
import 'package:project/solo/lose.dart';
import 'package:project/solo/win.dart';
import '../main.dart';
import '../Elements/index.dart';

List<dynamic> games = [Jeux4(),Jeux4(),Jeux4()];

var currentGame;

var mancheWin;

var nbManche = 0;

void starGame(){

  Random random = Random();

  int randomNumber = 0 + random.nextInt(games.length);

  print(randomNumber);

  currentGame = games[randomNumber];
}

void supprGame(){
  games.remove(currentGame);
}

void gestion(BuildContext context){
  print(games);
  if(mancheWin == false){
    games = [Jeux4(),Jeux4(),Jeux4()];
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Lose()),
                  );
  }
  else if(nbManche == 3){
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Win()),
                  );
  }
  else{
    starGame();
    supprGame();
    nbManche++;
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => currentGame),
                  );
  }
}