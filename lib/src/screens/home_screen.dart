import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../screens/widgets/company_widget.dart';
import '../screens/widgets/dialog.dart';

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
    if (controller.companies.isEmpty) {
      return const Center(child: Text('Nothing to show'));
    }

    return ListView.builder(
      itemCount: controller.companies.length,
      itemBuilder: (_, i) {
        final company = controller.companies.toList()[i];

        return CompanyWidget(
          company: company,
          onTap: () => Get.toNamed('/assets', arguments: company),
          // onTap: () => Get.to(const AssetsScreen()),
        );
      },
    );
  }
}
