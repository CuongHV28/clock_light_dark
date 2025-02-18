import 'package:clock_light_dark/screens/components/alarm_screen.dart';
import 'package:clock_light_dark/screens/components/stopwatch_screen.dart';
import 'package:clock_light_dark/screens/components/timer_screen.dart';
import 'components/clock_container.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // we have to call this on our starting page
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/clock');
              },
              child: const Text('Clock'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/alarms');
              },
              child: const Text('Alarms'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/timer');
              },
              child: const Text('Timer'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/stopwatch');
              },
              child: const Text('Stopwatch'),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/Settings.svg",
          // color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () {},
      ),
    );
  }
}