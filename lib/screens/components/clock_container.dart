import 'package:flutter/material.dart';
import 'clock.dart';
import 'time_handler.dart';

class ClockContainer extends StatelessWidget {
  const ClockContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Text(
              "Hà Nội, Việt Nam",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const TimeHandler(),
            const Spacer(),
            const ClockWidget(),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
