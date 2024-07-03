class Location {
  Location({
    required this.id,
    required this.name,
    this.parentId,
    this.children = const [],
  });

  final String id;
  final String name;
  final String? parentId;
  final List<Location> children;
}
