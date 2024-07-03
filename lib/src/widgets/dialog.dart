import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showDialog(String title, String content) async {
  final dialog = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      TextButton(
        onPressed: () => Get.back(), // Close the dialog
        child: const Text('Close'),
      ),
    ],
  );

  await Get.dialog(dialog);
}

void showErrorDialog(Object content) async {
  final dialog = AlertDialog(
    title: const Text('An Error Occurred!'),
    content: Text(content.toString()),
    actions: [
      TextButton(
        onPressed: () => Get.back(), // Close the dialog
        child: const Text('Close'),
      ),
    ],
  );

  await Get.dialog(dialog);
}
