import 'package:flutter/material.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';

class MyTimePickerDialog extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const MyTimePickerDialog({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyTimePickerDialogState createState() => _MyTimePickerDialogState();
}

class _MyTimePickerDialogState extends State<MyTimePickerDialog> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime;
  }

  void _onTimeChanged(DateTime dateTime) {
    setState(() {
      _selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
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
            TimePickerSpinner(
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
