import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<Controller>();
  @override
  void initState() {
    controller.fetchCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Obx(() => body(context)),
      ),
    );
  }

  Widget body(BuildContext context) {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }
    if (controller.companies.isEmpty) return const Text('No Companies found');

    return ListView.builder(
      itemCount: controller.companies.length,
      itemBuilder: (_, i) {
        final company = controller.companies[i];
        return ListTile(
          title: Text(company.name),
          subtitle: Text(company.id),
        );
      },
    );
  }
}
