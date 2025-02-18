import 'package:clock_light_dark/screens/components/alarm_screen.dart';
import 'package:clock_light_dark/screens/components/clock_container.dart';
import 'package:clock_light_dark/screens/components/stopwatch_screen.dart';
import 'package:clock_light_dark/screens/components/timer_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'models/custom_theme_provider.dart';
import 'screens/home_view.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final DarwinInitializationSettings initializationSettingsDarwin = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    
  );

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );

  
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clock Light Dark',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreenWidget(),
        '/clock': (context) => const ClockContainer(),
        '/alarms': (context) => const AlarmScreen(),
        '/timer': (context) => const TimerScreen(),
        '/stopwatch': (context) => const StopwatchScreen(),
      },
    );
  }
}

class NavigationHandler {
  static const platform = MethodChannel('com.thotx.clock-dark-light/navigation');

  static void initialize(BuildContext context) {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'navigateTo') {
        final viewPath = call.arguments as String;
        Navigator.pushNamed(context, viewPath);
      }
    });
  }
}