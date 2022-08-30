import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_app/models/TemperatureDataset.dart';
import 'package:smart_home_app/widgets/tempertaureLineChart.dart';

class ClimateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return Scaffold(
        appBar: AppBar(title: const Text("Todays Temperatures")),
        body: Consumer<TemperatureDataset>(
          builder: (((context, value, child) => TemperatureLineChart(
              value.getMeasures(today.year, today.month, today.day)))),
        ));
  }
}
