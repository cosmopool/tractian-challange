import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../widgets/company_widget.dart';
import '../widgets/dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.find<Controller>();

  @override
  void initState() {
    controller.fetchCompanies(onError: showErrorDialog);
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

        return CompanyWidget(
          company: company,
          onTap: () {},
        );
      },
    );
  }
}
