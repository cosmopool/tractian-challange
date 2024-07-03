import '../core/constants.dart';
import 'node.dart';

class Company {
  Company({
    required this.id,
    required this.name,
    required this.children,
  });

  final String id;
  final String name;
  Set<TreeNode> children;

  static fromJson(Map<String, dynamic> map) {
    return Company(
      id: map[kId],
      name: map[kName],
      children: {},
    );
  }

  void add(TreeNode node) => children.add(node);
}
