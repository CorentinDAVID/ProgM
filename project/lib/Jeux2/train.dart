import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class Jeux2Train extends StatefulWidget {
  @override
  _Jeux2State createState() => _Jeux2State();
}

class _Jeux2State extends State<Jeux2Train> {
  String _countryName = 'Loading...';
  LatLng _center = LatLng(0.0, 0.0);
  static const double _kHeightFraction = 0.8;
  List<String> _countries = [];
  int _score = 0;
  LatLng _markerPosition = LatLng(0.0, 0.0);
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _createCountryList();
  }

  Future<void> _createCountryList() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
    final countries = json.decode(response.body) as List<dynamic>;
    setState(() {
      _countries = countries
          .map((country) => country['name']['common'].toString())
          .toList();
    });
    _loadRandomCountry();
  }

  void _loadRandomCountry() {
    if (_score >= 3) {
      // Terminer le jeu
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Game Over'),
          content: Text('Score: $_score'),
          actions: [
            TextButton(
              child: Text('Restart'),
              onPressed: () {
                Navigator.pop(context);
                _restartGame();
              },
            ),
          ],
        ),
      );
    } else {
      final random = Random();
      final countryName = _countries[random.nextInt(_countries.length)];
      setState(() {
        _countryName = countryName;
      });
      _getCountryLocation();
    }
  }

  void _restartGame() {
    setState(() {
      _score = 0;
    });
    _loadRandomCountry();
  }

  void _getCountryLocation() async {
    final response = await http.get(Uri.parse(
        'https://restcountries.com/v3.1/name/${_countryName.toLowerCase().replaceAll(' ', '-')}'));

    final countries = json.decode(response.body) as List<dynamic>;
    final country = countries.first;

    final location = country['latlng'];
    if (location != null && location.length >= 2) {
      setState(() {
        _center = LatLng(location[0], location[1]);
      });
    }
  }

  void _checkCountryName() {
    if (_markerPosition == null) {
      return;
    }
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${_markerPosition.latitude}&lon=${_markerPosition.longitude}');
    http.get(url).then((response) {
      final data = json.decode(response.body);
      final countryName = data['address']['country'];
      if (countryName.toLowerCase() == _countryName.toLowerCase()) {
        setState(() {
          _score++;
        });
      }
      _loadRandomCountry();
    });
  }

  void _moveMarker(LatLng position) {
    setState(() {
      _markerPosition = position;
    });
  }

  void _zoomIn() {
    _mapController.move(_center, _mapController.zoom + 1);
  }

  void _zoomOut() {
    _mapController.move(_center, _mapController.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * _kHeightFraction;
    final width = MediaQuery.of(context).size.width;

    return MaterialApp(
      title:
          'Guess the country - Score: $_score - Country: $_countryName - Marker: $_markerPosition',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
              'Country: $_countryName'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: height,
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: _center,
                    zoom: 2.0,
                    onTap: _moveMarker,
                  ),
                  layers: [
                    TileLayerOptions(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: ['a', 'b', 'c'],
                    ),
                    MarkerLayerOptions(
                      markers: [
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: _markerPosition,
                          builder: (ctx) => Container(
                            child: Icon(
                              Icons.location_pin,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.zoom_in),
                  onPressed: _zoomIn,
                ),
                IconButton(
                  icon: Icon(Icons.zoom_out),
                  onPressed: _zoomOut,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _checkCountryName,
              child: Text('Guess'),
            ),
          ],
        ),
      ),
    );
  }
}
