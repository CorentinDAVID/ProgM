import 'dart:async';
import 'package:flutter/material.dart';
import 'package:microphone_stream/microphone_stream.dart';

class SoundMeter extends StatefulWidget {
  @override
  _SoundMeterState createState() => _SoundMeterState();
}

class _SoundMeterState extends State<SoundMeter> {
  late StreamSubscription<MicrophoneStreamReading> _streamSubscription;
  double _dbLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _streamSubscription = MicrophoneStream.microphoneStream.listen((data) {
      setState(() {
        _dbLevel = data.decibels;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '${_dbLevel.toStringAsFixed(2)} dB',
        style: TextStyle(fontSize: 32),
      ),
    );
  }
}
