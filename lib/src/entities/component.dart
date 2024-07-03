class Component {
  Component({
    required this.id,
    required this.name,
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
    this.parentId,
    this.locationId,
  });

  final String id;
  final String name;
  final String sensorId;
  final String sensorType;
  final String status;
  final String gatewayId;
  final String? parentId;
  final String? locationId;
}
