import '../core/constants.dart';
import '../core/exceptions.dart';
import 'asset.dart';
import 'node.dart';

class Component extends TreeNode implements Asset {
  Component({
    required super.id,
    required super.name,
    super.parentId,
    super.locationId,
    super.children = const {},
    required this.sensorId,
    required this.sensorType,
    required this.status,
    required this.gatewayId,
  });

  final String sensorId;
  final SensorType sensorType;
  final Status status;
  final String gatewayId;

  static fromJson(Map<String, dynamic> data) {
    return Component(
      id: data[kId],
      name: data[kName],
      locationId: data[kLocationId],
      parentId: data[kParentId],
      sensorId: data[kSensorId],
      gatewayId: data[kGatewayId],
      sensorType: sensorTypeByName(data[kSensorType]),
      status: statusByName(data[kStatus]),
    );
  }
}

enum Status { operating, alert }

/// Return a [Status] with same [name] or throw a [UnrecognizedType]
/// [name] is converted to lower case before comparing.
Status statusByName(String name) {
  final value = name.toLowerCase();
  return Status.values.firstWhere(
    (e) => e.name.toLowerCase() == value,
    orElse: () => throw UnrecognizedType(name, Status),
  );
}

enum SensorType { vibration, energy }

/// Return a [SensorType] with same [name] or throw a [UnrecognizedType]
/// [name] is converted to lower case before comparing.
SensorType sensorTypeByName(String name) {
  final value = name.toLowerCase();
  return SensorType.values.firstWhere(
    (e) => e.name.toLowerCase() == value,
    orElse: () => throw UnrecognizedType(value, SensorType),
  );
}
