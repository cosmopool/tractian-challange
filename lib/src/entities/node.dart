abstract class TreeNode {
  TreeNode({
    required this.id,
    required this.name,
    required this.children,
    this.parentId,
    this.locationId,
  });

  final String id;
  final String name;
  final String? parentId;
  final String? locationId;
  final Set<TreeNode> children;

  String? get parentNodeId => parentId ?? locationId;

  void add(TreeNode node) => children.add(node);
  void addAll(List<TreeNode> nodes) => children.addAll(nodes);
}
