import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:smart_home_app/models/sensor.dart';
import 'package:smart_home_app/models/temperatureData.dart';
import 'package:http/http.dart' as http;

Future<List<TemperatureData>> fetchTemperatureData(int year, int month) async {
  final response = await http.get(Uri.parse(
      "http://philipp-geil.ddns.net/temperatureData/sensor0/${year}_${month}.csv"));

  if (response.statusCode != 200) {
    throw Exception(response.body);
  }

  final lines =
      response.body.split('\n').skip(1).takeWhile((value) => value != "");
  return lines.map<TemperatureData>((line) {
    final parts = line.split(',');

    DateTime time = DateTime.parse(parts[0]);
    final temperature = num.parse(parts[1]);

    return TemperatureData(0, time, temperature);
  }).toList();
}

Future<List<Sensor>> getSensors() async {
  final response = await http.get(
      Uri.parse('http://philipp-geil.ddns.net/temperatureData/sensors.json'));

  if (response.statusCode != 200) {
    throw Exception(response.body);
  }

  return (jsonDecode(response.body) as List<dynamic>)
      .map((e) => Sensor.fromJson(e))
      .toList();
}

class TemperatureDataset extends ChangeNotifier {
  final List<Sensor> _sensors = [];
  final List<TemperatureData> _data = [];

  UnmodifiableListView<Sensor> get sensors => UnmodifiableListView(_sensors);
  int get sensorsCount => _sensors.length;

  UnmodifiableListView<TemperatureData> get temperatureData =>
      UnmodifiableListView(_data);

  TemperatureDataset() {
    final today = DateTime.now();

    getSensors().then((value) => addSensors(value));
    fetchTemperatureData(today.year, today.month)
        .then((value) => addData(value));
  }

  void addSensor(Sensor sensor) {
    _sensors.add(sensor);
    notifyListeners();
  }

  void addSensors(Iterable<Sensor> sensors) {
    _sensors.addAll(sensors);
    notifyListeners();
  }

  void addData(Iterable<TemperatureData> data) {
    _data.addAll(data);
    notifyListeners();
  }

  void addMeasure(TemperatureData measure) {
    _data.add(measure);
    notifyListeners();
  }

  TemperatureData? getLatestMeasure(int sensorId) {
    if (_data.isEmpty) {
      return null;
    }

    return _data.lastWhere((measure) => measure.sensorId == sensorId);
  }

  UnmodifiableListView<TemperatureData> getMeasures(
      int year, int month, int day) {
    return UnmodifiableListView(_data.where((measure) =>
        measure.time.year == year &&
        measure.time.month == month &&
        measure.time.day == day));
  }

  void clearData() {
    _data.clear();
    notifyListeners();
  }

  void clearSensors() {
    _sensors.clear();
    notifyListeners();
  }

  void removeSensor(int id) {
    var index = _sensors.indexWhere((element) => element.sensorId == id);

    if (index == -1) return;

    _sensors.removeAt(index);
    notifyListeners();
  }
}
