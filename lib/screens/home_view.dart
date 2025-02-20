import 'package:clock_light_dark/screens/components/alarm_screen.dart';
import 'package:clock_light_dark/screens/components/stopwatch_screen.dart';
import 'package:clock_light_dark/screens/components/timer_screen.dart';
import 'components/clock_container.dart';
import '../size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreenWidget extends StatelessWidget {
  const HomeScreenWidget({super.key});

  static const platform =
      MethodChannel('com.thotx.clock-dark-light/navigation');

  @override
  Widget build(BuildContext context) {
    // we have to call this on our starting page
    SizeConfig().init(context);

    // Ensure the method channel is set up after the HomeScreenWidget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      platform.setMethodCallHandler((call) async {
        if (call.method == 'navigateTo') {
          final viewPath = call.arguments as String;
          print('Navigating to $viewPath');
          // Use a context that is a descendant of a Navigator widget
          Navigator.pushNamed(context, viewPath);
        }
      });

      // Log a message to notify that the method channel is created
      print('MethodChannel created successfully!');
    });

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