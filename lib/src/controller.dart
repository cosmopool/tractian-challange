import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'entities/asset.dart';
import 'entities/company.dart';
import 'entities/location.dart';
import 'entities/node.dart';
import 'repository.dart';

typedef VoidCallback = void Function();
typedef ErrorCallback = void Function(Object);

class Controller {
  Controller(this.repo);

  final Repository repo;

  Set<Company> companies = {};
  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  Future<void> fetchCompanies({required ErrorCallback onError}) async {
    _isLoading.value = true;

    try {
      companies = await repo.fetchCompanies();
    } catch (e) {
      if (kDebugMode) debugPrint(e.toString());
      onError(e);
    }

    _isLoading.value = false;
  }

  Future<void> fetchLocations(
    Company company, {
    required ErrorCallback onError,
  }) async {
    _isLoading.value = true;

    try {
      final locations = await repo.fetchLocations(company);
      final assets = await fetchAssets(company, onError: onError);
      company.children = _buildTree(company, locations, assets);
    } catch (e) {
      if (kDebugMode) debugPrint(e.toString());
      onError(e);
    }

    _isLoading.value = false;
  }

  Future<Set<Asset>> fetchAssets(
    Company company, {
    required ErrorCallback onError,
  }) async {
    _isLoading.value = true;

    try {
      final assets = await repo.fetchAssets(company);
      return assets;
    } catch (e) {
      if (kDebugMode) debugPrint(e.toString());
      onError(e);
    }

    _isLoading.value = false;
    return {};
  }

  Set<TreeNode> _buildTree(
    Company company,
    Set<Location> location,
    Set<Asset> assets,
  ) {
    // create a map to hold all nodes by their id
    Map<String, TreeNode> nodeMap = {};

    // add nodes to nodeMap
    for (var node in location) {
      nodeMap[node.id] = node;
    }
    for (var node in assets) {
      nodeMap[node.id] = node;
    }

    // create new tree
    final tree = <TreeNode>{};
    // popule tree by assigning nodes to their parents
    nodeMap.forEach((id, node) {
      // populate nodes that are on tree root
      if (node.parentNodeId == null) {
        tree.add(node);
        return;
      }

      // find parent node
      final parentNode = nodeMap[node.parentNodeId];
      // throw error if parent node could not be found
      if (parentNode == null) {
        throw Exception('Couldn\'t find the node: ${node.parentNodeId}');
      }
      // add node in parent
      return parentNode.add(node);
    });

    return tree;
  }
}
