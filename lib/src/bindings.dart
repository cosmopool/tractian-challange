import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'repository.dart';

class MainBindings extends Bindings {
  MainBindings([this.dio]);

  final Dio? dio;

  @override
  void dependencies() {
    Get.put<Dio>(dio ?? Dio());
    Get.lazyPut<Repository>(() => Repository(Get.find()));
    Get.lazyPut<Controller>(() => Controller(Get.find()));
  }
}
