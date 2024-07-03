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
    if (!_isLoading.value) _isLoading.value = true;

    try {
      locations = await repo.fetchLocations(company);
    } catch (e) {
      if (kDebugMode) debugPrint(e.toString());
      onError(e);
    }

    _isLoading.value = false;
  }
}
