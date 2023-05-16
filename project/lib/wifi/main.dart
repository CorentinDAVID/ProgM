import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:project/Jeux1/main.dart';
import 'package:project/Jeux2/main.dart';
import 'package:project/Jeux3/main.dart';
import 'package:project/Jeux4/main.dart';
import 'package:project/Jeux5/main.dart';
import 'package:project/Jeux6/main.dart';
import 'package:project/wifi/resultat.dart';

bool _isHost = false;
var myScore;
var isScore;
List<String> winner = [];
List<dynamic> lsGames = [Jeux1(),Jeux2(),ShakeGame(),Jeux4(),MazeGame(),MemoryGame()];
var currentGame;
var vainqueur;

class ConnectionWidget extends StatefulWidget {
  @override
  _ConnectionWidgetState createState() => _ConnectionWidgetState();
}

class _ConnectionWidgetState extends State<ConnectionWidget> {
  final FlutterP2pConnection _flutterP2pConnectionPlugin = FlutterP2pConnection();
  bool _isConnected = false;
  WifiP2PInfo? wifiP2PInfo;
  

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _flutterP2pConnectionPlugin.removeGroup();
    super.dispose();
  }

  void _init() async {
    await _flutterP2pConnectionPlugin.initialize();
  }

  void _connect() async {
    if (!await _flutterP2pConnectionPlugin.checkStoragePermission()) {
      _flutterP2pConnectionPlugin.askStoragePermission();
    }
    if (!await _flutterP2pConnectionPlugin.checkLocationPermission()) {
      _flutterP2pConnectionPlugin.askLocationPermission();
    }
    if (!await _flutterP2pConnectionPlugin.checkLocationEnabled()) {
      _flutterP2pConnectionPlugin.enableLocationServices();
    }
    if (!await _flutterP2pConnectionPlugin.checkWifiEnabled()) {
      _flutterP2pConnectionPlugin.enableWifiServices();
    }
    _flutterP2pConnectionPlugin.register();
    _flutterP2pConnectionPlugin.discover();
    _flutterP2pConnectionPlugin.streamPeers().listen((List<DiscoveredPeers> event) {
      if (event.isNotEmpty) {
        for (int i = 0; i < event.length; i++) {
          _flutterP2pConnectionPlugin.connect(event[i].deviceAddress);
        }
      }
    });
    _flutterP2pConnectionPlugin.streamWifiP2PInfo().listen((event) {
      wifiP2PInfo = event;
      if (event.isConnected) {
        setState(() {
          _isConnected = true;
        });
      }
    });

    print(_isConnected);
  }

  Future _startSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.startSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress!,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (name, address) {
          print("$name connected to socket with address: $address");
        },
        transferUpdate: (transfer) {
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        receiveString: (req) async {
          print(req);
          isScore = req as int;
          if(isScore > myScore){
            winner.add('Joueur2');
          }
          else{winner.add('Joueur1');}
        },
      );
    }
  }

  Future _connectToSocket() async {
    if (wifiP2PInfo != null) {
      await _flutterP2pConnectionPlugin.connectToSocket(
        groupOwnerAddress: wifiP2PInfo!.groupOwnerAddress!,
        downloadPath: "/storage/emulated/0/Download/",
        maxConcurrentDownloads: 2,
        deleteOnError: true,
        onConnect: (address) {
          print("connected to socket: $address");
        },
        transferUpdate: (transfer) {
          print(
              "ID: ${transfer.id}, FILENAME: ${transfer.filename}, PATH: ${transfer.path}, COUNT: ${transfer.count}, TOTAL: ${transfer.total}, COMPLETED: ${transfer.completed}, FAILED: ${transfer.failed}, RECEIVING: ${transfer.receiving}");
        },
        receiveString: (req) async {
          print(req);
          if(req == 'score'){
            showAlertDialog(context, 'message', 'hello');
          }
          else if(req == 'Jeux1' || req == 'Jeux2' || req == 'Jeux3' || req == 'Jeux4' || req == 'Jeux5' || req == 'Jeux6'){
            currentGame = converterStoI(req);
            Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => lsGames[currentGame]),
                        );
          }
        },
      );
    }
  }

  void _sendMessage(String m) {
    _flutterP2pConnectionPlugin.sendStringToSocket(m);
  }

  void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
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

void peekGame(){
  Random random = Random();

  int randomNumber = 0 + random.nextInt(lsGames.length);

  print(randomNumber);

  currentGame = randomNumber;
}

String theWinner(){
  var j1 = 0;
  var j2 = 0;
  for(var i in winner){
    if(i == 'Joueur1'){
      j1++;
    }
    else{j2++;}
  }
  if(j1>j2){
    return 'Joueur1';
  }
  else{
    return 'Joueur2';
  }
}
void supprGame(){
  lsGames.remove(lsGames[currentGame]);
}

void finDeManche(int s){
  if(_isHost){
    myScore = s;
    gestion();
  }
  else{
    _flutterP2pConnectionPlugin.sendStringToSocket(s as String);
  }
}

void gestion(){
  if(winner.length < 3){
    peekGame();
    _sendMessage(converterItoS(currentGame));
    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => lsGames[currentGame]),
                        );
  }
  else{
    vainqueur = theWinner();
    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Resultat()),
                        );
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion P2P'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _connect,
              child: Text('Se connecter'),
            ),
            SizedBox(height: 20),
            Text(
              _isConnected ? 'Connecté' : 'Non connecté',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed:() {
                _isHost = true;
                print(_isHost);
                _startSocket;
                print(_isHost);
              },
              child: Text('Start Socket'),
            ),
            ElevatedButton(
              onPressed: _connectToSocket,
              child: Text('Connect to Socket'),
            ),
            ElevatedButton(
              onPressed: gestion,
              child: Text('Start Game'),
            )
          ],
        ),
      ),
    );
  }
}

String converterItoS(int i){
  if(i == 0)return 'Jeux1';
  else if(i == 1)return 'Jeux2';
  else if(i == 2)return 'Jeux3';
  else if(i == 3)return 'Jeux4';
  else if(i == 4)return 'Jeux5';
  else return 'Jeux6';
}

int converterStoI(String s){
  if(s == 'Jeux1')return 0;
  else if(s == 'Jeux2')return 1;
  else if(s == 'Jeux3')return 2;
  else if(s == 'Jeux4')return 3;
  else if(s == 'Jeux5')return 4;
  else return 5;
}
