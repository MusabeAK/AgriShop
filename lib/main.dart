import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';

import 'crops.dart';
import 'animals.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Landing Page"),
        ),
        body: ListView(
          children: [
            // const ListTile(
            //   leading: Icon(Icons.water_drop),
            //   title: Text("Crops"),
            // ),
            ListTile(
              trailing: const Icon(Icons.keyboard_arrow_right),
              title: const Text("Animals"),
              onTap: () {
                Get.to(() => const Animals());
              },
            ),
            ListTile(
              trailing: const Icon(Icons.keyboard_arrow_right),
              title: const Text("Crops"),
              onTap: () {
                Get.to(() => const Crops());
              },
            ),
          ],
        ),
      ),
    );
  }
}
