import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_p2p_connection/flutter_p2p_connection.dart';
import 'package:project/main.dart';

class Wifi extends StatefulWidget {
  const Wifi({super.key});

  @override
  State<Wifi> createState() => _MultijoueursPageState();
}

class _MultijoueursPageState extends State<Wifi> {
  final _flutterP2pConnectionPlugin = FlutterP2pConnection();
  WifiP2PInfo? wifiP2PInfo;

  final TextEditingController _controller = TextEditingController();
  String? _pseudo;
  bool _isConnected = false;

  StreamSubscription<WifiP2PInfo>? _streamWifiInfo;
  StreamSubscription<List<DiscoveredPeers>>? _streamPeers;

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _flutterP2pConnectionPlugin.removeGroup();
    _streamWifiInfo?.cancel();
    _streamPeers?.cancel();
    super.dispose();
  }

  void _init() async {
    await _flutterP2pConnectionPlugin.initialize();
  }

  void _connect() async {
    /*String name = _controller.text.trim();
    print(name);
    if (name.isEmpty) {
      return;
    }*/
    _streamWifiInfo =
        _flutterP2pConnectionPlugin.streamWifiP2PInfo().listen((event) {
      wifiP2PInfo = event;
      print(event);
      if (event.isConnected) {
        setState(() {
          _isConnected = true;
          Navigator.push(context, MaterialPageRoute(builder: (context) => StartPage()));
        });
      }
    });
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
    _streamPeers = _flutterP2pConnectionPlugin.streamPeers().listen((event) {
      print(event);
      if (event.isNotEmpty) {
        for (int i = 0; i < event.length; i++) {
          _flutterP2pConnectionPlugin.connect(event[i].deviceAddress);
        }
      }
    });
  }

  void _setPseudo() {
    setState(() {
      _pseudo = _controller.text;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 99, 71, 255),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, right: 20),
              alignment: Alignment.topRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StartPage()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 162, 136, 255)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ))),
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            const SizedBox(height: 200),
            _pseudo == null
                ? Column(
                    children: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 136, 154, 255)),
                        child: Column(children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text('nom',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                          TextField(
                            controller: _controller,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 74, 71, 255),
                              labelText: "Pseudo",
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Color.fromARGB(255, 71, 99, 255))),
                              constraints: BoxConstraints(maxWidth: 220),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ]),
                      ),
                      const SizedBox(height: 30),
                      Container(
                          width: 300,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                              color: Color.fromARGB(255, 20, 130, 255)),
                          child: TextButton(
                            onPressed: () {
                              if (_controller.text.isEmpty) {
                                return;
                              } else {
                                _setPseudo();
                                _connect();
                              }
                            },
                            child: const Text('VALIDER',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ))
                    ],
                  )
                : _isConnected
                    ? //Container()
                    Column(
                        children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 136, 138, 255)),
                            child:  Column(children: const[
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text('Joueurs connectés : ',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              SizedBox(height: 20),
                            ]),
                          ),
                          const SizedBox(height: 30),
                          Container(
                              width: 300,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 20, 24, 255)),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text('JOUER',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              )),
                        ],
                      )
                    : Column(
                        children: [
                          Container(
                            width: 300,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: Color.fromARGB(255, 138, 136, 255)),
                            child:  Column(children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Text('En attente des autres joueurs...',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              ),
                              SizedBox(height: 10),
                              CircularProgressIndicator(),
                              SizedBox(height: 20),
                            ]),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}