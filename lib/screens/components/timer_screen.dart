import 'package:flutter/material.dart';
import 'dart:async';
import 'time_picker_dialog.dart'; // Import your custom time picker dialog

class TimerScreen extends StatefulWidget {
  const TimerScreen({super.key});

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int _start = 60; // Set the initial timer value (in seconds)

  void startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer!.cancel();
        }
      });
    });
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  void resetTimer() {
    stopTimer();
    setState(() {
      _start = 60; // Reset the timer value
    });
  }

  Future<void> pickTime() async {
    TimeOfDay selectedTime = TimeOfDay(hour: 0, minute: 1);
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick Time'),
          content: MyTimePickerDialog(
            initialTime: selectedTime,
            onTimeChanged: (TimeOfDay time) {
              selectedTime = time;
            },
            mode: TimePickerMode.timer,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _start = selectedTime.hour * 3600 +
                      selectedTime.minute * 60; // Convert to seconds
                });
                Navigator.of(context).pop();
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }

  String formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hẹn giờ',
            style: TextStyle(
                color: Colors.blueGrey[200], fontWeight: FontWeight.w200)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              formatTime(_start),
              style: TextStyle(fontSize: 48),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickTime,
              child: Text('Chọn thời gian',
                  style: TextStyle(
                      color: Colors.amber[800], fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: startTimer,
                  child: Text('Bắt đầu',
                      style: TextStyle(
                          color: Colors.lightGreen[700],
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: stopTimer,
                  child: Text('Dừng',
                      style: TextStyle(
                          color: Colors.red[800], fontWeight: FontWeight.bold)),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: Text('Đặt lại',
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
