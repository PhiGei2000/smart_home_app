import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_app/models/TemperatureDataset.dart';
import 'package:smart_home_app/screens/climate_screen.dart';
import 'package:smart_home_app/screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TemperatureDataset(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeScreen(),
        '/climate': (context) => ClimateScreen()
      },
    );
  }
}
