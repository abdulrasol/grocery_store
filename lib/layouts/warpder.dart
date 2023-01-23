import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/authenticate/sign_in.dart';
import 'package:grocery_store/layouts/home/home_warper.dart';
import 'package:grocery_store/services/auth_controller.dart';
//import 'package:grocery_store/services/database_dontroller.dart';

class Warper extends StatelessWidget {
  Warper({Key? key}) : super(key: key);

  final AuthController controller = Get.put(AuthController());
  //final DatabaseController dbController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return HomeWarper();
  }
}
