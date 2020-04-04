import 'package:falcon_corona_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/start_screen.dart';
import 'screens/begin_screen.dart';
import 'screens/temperature_screen.dart';
import 'screens/in_quarantine_screen.dart';
import 'screens/warning_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falcon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/':(context) => StartScreen(),
        '/begin':(context) => BeginScreen(),
        '/temperature':(context) => TemperatureScreen(),
        '/inquarantine':(context) => InQuarantineScreen(),
        '/warning':(context) => HomeScreen(),
      },
      );
  }
}
