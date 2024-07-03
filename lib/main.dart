import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/bindings.dart';
import 'src/screens/assets_screen.dart';
import 'src/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bindings = MainBindings();

    return GetMaterialApp(
      title: 'Tractian Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3D90FF)),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: bindings,
        ),
        GetPage(
          name: '/assets',
          page: () => const AssetsScreen(),
          binding: bindings,
        ),
      ],
      // initialBinding: ,
    );
  }
}
