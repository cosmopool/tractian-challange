import '../core/constants.dart';
import 'node.dart';

abstract class Asset extends TreeNode {
  Asset({
    required super.id,
    required super.name,
    required super.children,
    super.parentId,
    super.locationId,
  });
}

class AssetContainer extends Asset {
  AssetContainer({
    required super.id,
    required super.name,
    required super.children,
    super.parentId,
    super.locationId,
  });

  static fromJson(Map<String, dynamic> data) {
    return AssetContainer(
      id: data[kId],
      name: data[kName],
      parentId: data[kParentId],
      locationId: data[kLocationId],
      children: {},
    );
  }
}
