import 'asset.dart';

class Location {
  Location({
    required this.id,
    required this.name,
    this.parentId,
    this.children = const [],
    this.assets = const [],
  });

  final String id;
  final String name;
  final String? parentId;
  final List<Location> children;
  final List<Asset> assets;

  static fromJson(Map<String, dynamic> data) {
    return Location(
      id: data['id'],
      name: data['name'],
      parentId: data['parentId'] ?? '',
      children: [],
      assets: [],
    );
  }
}
