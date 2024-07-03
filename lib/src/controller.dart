import 'package:get/get.dart';

import 'entities/company.dart';
import 'repository.dart';

class Controller {
  Controller(this.repo);

  final Repository repo;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  List<Company> companies = [];

  Future<void> fetchCompanies() async {
    _isLoading.value = true;
    companies = await repo.fetchCompanies();
    _isLoading.value = false;
  }
}
