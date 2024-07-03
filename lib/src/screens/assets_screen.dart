import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../entities/asset.dart';
import '../entities/company.dart';
import '../entities/component.dart';
import '../entities/node.dart';
import '../screens/widgets/dialog.dart';

class AssetsScreen extends StatefulWidget {
  const AssetsScreen({super.key});

  @override
  State<AssetsScreen> createState() => _AssetsScreenState();
}

class _AssetsScreenState extends State<AssetsScreen> {
  final controller = Get.find<Controller>();
  final company = Get.arguments as Company;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchLocations(company, onError: showErrorDialog);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final appBarTitle = Text(
      'Assets',
      style: TextStyle(color: colors.onInverseSurface),
    );
    final appBarBackButton = InkWell(
      onTap: Get.back,
      child: Icon(Icons.arrow_back_ios_rounded, color: colors.onInverseSurface),
    );
    final appBar = AppBar(
      backgroundColor: colors.onSurface,
      leading: appBarBackButton,
      title: appBarTitle,
      centerTitle: true,
    );

    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        body: Obx(() => body()),
      ),
    );
  }

  Widget body() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (company.children.isEmpty) {
      return const Center(child: Text('Nothing to show'));
    }

    return SingleChildScrollView(
      child: Column(
        children: _buildTreeViewNodes(company.children),
      ),
    );
  }

  List<Widget> _buildTreeViewNodes(Set<TreeNode> nodes) {
    return nodes.map((node) {
      if (node is Component) {
        return ListTile(
          leading: const Icon(Icons.indeterminate_check_box_outlined),
          title: Text(node.name),
        );
      }

      late final Icon icon;
      if (node is AssetContainer) {
        icon = const Icon(Icons.check_box_outline_blank);
      } else {
        icon = const Icon(Icons.location_on_outlined);
      }

      return ExpansionTile(
        title: Row(children: [icon, Text(node.name)]),
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: const EdgeInsets.only(left: 16),
        children: _buildTreeViewNodes(node.children),
      );
    }).toList();
  }
}
