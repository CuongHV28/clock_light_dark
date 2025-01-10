import 'package:clock_light_dark/models/custom_theme_provider.dart';
import 'package:clock_light_dark/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CustomThemeModel(),
        child: Consumer<CustomThemeModel>(
          builder: (context, theme, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Analog Clock',
            theme: themeData(context),
            darkTheme: darkThemeData(context),
            themeMode: theme.isLightTheme ? ThemeMode.light : ThemeMode.dark,
            home: const HomeScreenWidget(),
          ),
        ));
  }
}
