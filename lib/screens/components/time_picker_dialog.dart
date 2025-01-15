import 'package:flutter/material.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

enum TimePickerMode { alarm, timer }

const defaultStartTime = 1;

class MyTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final TimePickerMode mode;

  const MyTimePickerDialog({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    required this.mode,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyTimePickerDialogState createState() => _MyTimePickerDialogState();
}

class _MyTimePickerDialogState extends State<MyTimePickerDialog> {
  late TimeOfDay _selectedTime;
  late int _selectedSeconds;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
    _selectedSeconds = 0;
  }

  void _onTimeChanged(DateTime time) {
    setState(() {
      _selectedTime = TimeOfDay(hour: time.hour, minute: time.minute);
      _selectedSeconds = time.second;
    });
    widget.onTimeChanged(_selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            if (widget.mode == TimePickerMode.alarm) ...[
              TimePickerSpinner(
                time:
                    DateTime(0, 0, 0, _selectedTime.hour, _selectedTime.minute),
                is24HourMode: false,
                normalTextStyle:
                    TextStyle(fontSize: 24, color: Colors.amber[800]),
                highlightedTextStyle:
                    TextStyle(fontSize: 24, color: Colors.amber[800]),
                spacing: 50,
                itemHeight: 80,
                isForce2Digits: true,
                onTimeChange: _onTimeChanged,
              ),
            ] else ...[
              TimePickerSpinner(
                time: DateTime(0, 0, 0, _selectedTime.hour, defaultStartTime,
                    _selectedSeconds),
                is24HourMode: true,
                isShowSeconds: true,
                normalTextStyle:
                    TextStyle(fontSize: 24, color: Colors.amber[800]),
                highlightedTextStyle:
                    TextStyle(fontSize: 24, color: Colors.amber[800]),
                spacing: 50,
                itemHeight: 80,
                isForce2Digits: true,
                onTimeChange: _onTimeChanged,
              ),
            ],
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.amber[100]?.withOpacity(
                        0.5), // Background color for the selected time
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
