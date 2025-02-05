import 'dart:async';
import 'package:flutter/material.dart';
import '../../size_config.dart';

class TimeHandler extends StatefulWidget {
  const TimeHandler({super.key});

  @override
  State<TimeHandler> createState() => _TimeHandlerState();
}

class _TimeHandlerState extends State<TimeHandler> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeOfDay.minute != TimeOfDay.now().minute) {
        setState(() {
          _timeOfDay = TimeOfDay.now();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          // if you use _timeOfDay.hour then it will show 20:10 like that
          // But we want 8:10
          "${_timeOfDay.hourOfPeriod}:${_timeOfDay.minute}",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(width: 5),
        RotatedBox(
          quarterTurns: 3,
          child: Text(
            period,
            style: TextStyle(fontSize: getProportionateScreenWidth(18)),
          ),
        ),
      ],
    );
  }
}
