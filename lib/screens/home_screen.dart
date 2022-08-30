import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_app/models/TemperatureDataset.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home'),
      ),
      body: Center(
        child: Consumer<TemperatureDataset>(
          builder: ((context, value, child) {
            final data = value.getLatestMeasure(0);

            if (data != null) {
              return GestureDetector(
                onTap: () => {Navigator.pushNamed(context, '/climate')},
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.thermostat,
                          color: Colors.red,
                        ),
                        title: const Text('Latest temperature'),
                        subtitle: Text(
                            "${data.temperature}\xB0C on ${DateFormat('dd.MM.yyyy').format(data.time)} at ${DateFormat('HH:mm a').format(data.time)}"),
                      )
                    ],
                  ),
                ),
              );
            }

            return const Text('Loading...');
          }),
        ),
      ),
    );
  }
}
