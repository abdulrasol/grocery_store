import 'package:flutter/material.dart';
import 'package:grocery_store/layouts/home/home_warper.dart';
import 'package:get/get.dart';
import 'package:grocery_store/services/database.dart';

void main() async {
  Get.put(DatabaseController());
  runApp(GetMaterialApp(
    home: Scaffold(
      /* appBar: AppBar(
        title: const Text('Test API'),
      ), */
      body: HomeWarper(),
    ),
  ));
}
