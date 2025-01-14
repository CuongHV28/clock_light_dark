import 'package:flutter/material.dart';
import 'package:clock_light_dark/screens/components/time_picker_dialog.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  _AlarmScreenState createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  final List<Alarm> _alarms = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _alarmTimer;
  Timer? _soundTimer;
  int _soundDuration = 0;

  void _addAlarm() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TimeOfDay selectedTime = TimeOfDay.now();
        return AlertDialog(
          title: Text('Đặt báo thức',
              style: TextStyle(
                  color: Colors.blueGrey[200], fontWeight: FontWeight.w200)),
          content: MyTimePickerDialog(
            initialTime: selectedTime,
            onTimeChanged: (TimeOfDay time) {
              selectedTime = time;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _alarms.add(Alarm(time: selectedTime));
                    _scheduleAlarm(selectedTime);
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Lưu'),
            ),
          ],
        );
      },
    );
  }

  void _scheduleAlarm(TimeOfDay time) {
    final now = DateTime.now();
    final scheduledDate =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final duration = scheduledDate.difference(now);

    if (duration.isNegative) {
      // If the scheduled time is already passed for today, schedule it for tomorrow
      final tomorrow = scheduledDate.add(Duration(days: 1));
      final durationUntilTomorrow = tomorrow.difference(now);
      _alarmTimer = Timer(durationUntilTomorrow, _showAlarm);
    } else {
      _alarmTimer = Timer(duration, _showAlarm);
    }
  }

  void _showAlarm() {
    _playAlarmSound();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Báo thức'),
          content: const Text('Dậy đi con đĩ mẹ!'),
          actions: [
            TextButton(
              onPressed: () {
                _stopAlarmSound();
                Navigator.of(context).pop();
              },
              child: const Text('Cút'),
            ),
          ],
        );
      },
    );
  }

  void _playAlarmSound() {
    _soundDuration = 0;
    _soundTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (_soundDuration >= 60) {
        _soundTimer?.cancel();
      } else {
        await _audioPlayer.play(AssetSource('sounds/rooster-1.wav'));
        _soundDuration += 5;
      }
    });
  }

  void _stopAlarmSound() async {
    _soundTimer?.cancel();
    await _audioPlayer.stop();
  }

  @override
  void dispose() {
    _alarmTimer?.cancel();
    _soundTimer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo thức'),
      ),
      body: ListView.builder(
        itemCount: _alarms.length,
        itemBuilder: (context, index) {
          final alarm = _alarms[index];
          return ListTile(
            title: Text(alarm.time.format(context)),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                if (mounted) {
                  setState(() {
                    _alarms.removeAt(index);
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addAlarm,
        backgroundColor: Colors.amberAccent[200],
        child: const Icon(Icons.add),
      ),
    );
  }
}

class Alarm {
  final TimeOfDay time;

  Alarm({required this.time});
}
