import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:smart_home_app/models/temperatureData.dart';

class TemperatureLineChart extends StatelessWidget {
  late List<charts.Series<TemperatureData, DateTime>> seriesList;

  TemperatureLineChart(List<TemperatureData> data) {
    seriesList = <charts.Series<TemperatureData, DateTime>>[
      charts.Series(
        id: 'Raspberry pi',
        data: data,
        domainFn: ((datum, index) => datum.time),
        measureFn: ((datum, index) => datum.temperature),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: 750,
        padding: const EdgeInsets.all(10),
        child: charts.TimeSeriesChart(
          seriesList,
          primaryMeasureAxis: const charts.NumericAxisSpec(
              viewport: charts.NumericExtents(15, 32)),
        ),
      ),
    );
  }
}
