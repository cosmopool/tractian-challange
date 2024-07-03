import '../core/constants.dart';
import 'node.dart';

class Location extends TreeNode {
  Location({
    required super.id,
    required super.name,
    required super.children,
    super.parentId,
  });

  static fromJson(Map<String, dynamic> data) {
    return Location(
      id: data[kId],
      name: data[kName],
      parentId: data[kParentId],
      children: {},
    );
  }
}
