class Asset {
  Asset({
    required this.id,
    required this.name,
    this.locationId,
    this.parentId,
    this.children = const [],
  });

  final String id;
  final String name;
  final String? locationId;
  final String? parentId;
  final List<Asset> children;
}
