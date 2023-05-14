import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:project/Jeux3/main.dart';
import 'package:project/Jeux4/multi.dart';
import 'package:project/Jeux4/training.dart';
import 'package:project/lounge/resultat.dart';
import '../main.dart';
import '../Elements/index.dart';

List<dynamic> games = [Jeux4Multi(),Jeux4Multi(),Jeux4Multi()];

List<String> winner = [];

var gagnant;

var currentGame;

void addWinner(String w){
  winner.add(w);
}

void vainqueur(){
  var j1 = 0;
  var j2 = 0;
  for(var i in winner){
    if(i == "Joueur1"){
      j1++;
    }
    else{
      j2++;
    }
  }
  if(j1>j2){
    gagnant = "Joueur1";
  }
  else{
    gagnant = "Joueur2";
  }
}

void gestion(BuildContext context){
  print(winner);
  print(games);
  supprGame();
  if(winner.length == 3){
    games = [Jeux4Multi(),Jeux4Multi(),Jeux4Multi()];
    vainqueur();
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Resultat()),
                  );
  }
  else{
    starGame();
    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => currentGame),
                  );
  }
}

void starGame(){

  Random random = Random();

  int randomNumber = 0 + random.nextInt(games.length);

  print(randomNumber);

  currentGame = games[randomNumber];
}

void supprGame(){
  games.remove(currentGame);
}

