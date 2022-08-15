class Sensor {
  int sensorId;
  String sensorName;
  String ipAddress;

  Sensor(this.sensorId, this.sensorName, this.ipAddress);

  factory Sensor.fromJson(Map<String, dynamic> json) {
    return Sensor(json['id'], json['name'], json['ip']);
  }
}
