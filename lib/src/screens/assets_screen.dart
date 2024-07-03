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

    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        children: _buildTreeViewNodes(company.children, colors),
      ),
    );
  }

  List<Widget> _buildTreeViewNodes(Set<TreeNode> nodes, ColorScheme colors) {
    const style = TextStyle(fontSize: 14);

    return nodes.map((node) {
      if (node is Component) {
        Widget trailing = const SizedBox.shrink();
        if (node.status == Status.alert) {
          trailing = const Icon(Icons.circle, color: Colors.red);
        } else if (node.sensorType == SensorType.energy) {
          trailing = const Icon(Icons.bolt_rounded, color: Colors.green);
        }

        return ListTile(
          leading: Icon(
            Icons.check_box_outline_blank,
            color: colors.primary,
          ),
          title: Text(node.name, style: style),
          trailing: trailing,
        );
      }

      late final Icon icon;
      if (node is AssetContainer) {
        icon = Icon(
          Icons.all_inbox_outlined,
          color: colors.primary,
        );
      } else {
        icon = Icon(
          Icons.location_on_outlined,
          color: colors.primary,
        );
      }

      if (node.children.isEmpty) {
        return ListTile(
          dense: true,
          title: Row(children: [icon, Text(node.name, style: style)]),
        );
      }

      return ExpansionTile(
        dense: true,
        title: Row(children: [icon, Text(node.name, style: style)]),
        controlAffinity: ListTileControlAffinity.leading,
        childrenPadding: const EdgeInsets.only(left: 16),
        children: _buildTreeViewNodes(node.children, colors),
      );
    }).toList();
  }
}
