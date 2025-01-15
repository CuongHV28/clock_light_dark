import 'package:flutter/material.dart';
import 'dart:async';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({super.key});

  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void _startStopwatch() {
    _stopwatch.start();
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  void _stopStopwatch() {
    _stopwatch.stop();
    _timer.cancel();
  }

  void _resetStopwatch() {
    _stopwatch.reset();
    setState(() {});
  }

  String _formatTime(int milliseconds) {
    final int hours = milliseconds ~/ (1000 * 60 * 60);
    final int minutes = (milliseconds ~/ (1000 * 60)) % 60;
    final int seconds = (milliseconds ~/ 1000) % 60;
    final int centiseconds = (milliseconds ~/ 10) % 100;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}.${centiseconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đồng hồ bấm giờ',
            style: TextStyle(
                color: Colors.blueGrey[200], fontWeight: FontWeight.w200)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_stopwatch.elapsedMilliseconds),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed:
                      _stopwatch.isRunning ? _stopStopwatch : _startStopwatch,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _stopwatch.isRunning
                        ? Colors.red[800]
                        : Colors.lightGreen[700],
                  ),
                  child: Text(_stopwatch.isRunning ? 'Kết thúc' : 'Bắt đầu'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Đăt lại',
                      style: TextStyle(
                          color: Colors.amber[800],
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
