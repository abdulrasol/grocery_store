import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/pages/cart.dart';
import 'package:grocery_store/services/database_dontroller.dart';

final DatabaseController _databaseController = Get.put(DatabaseController());

class CartIcon extends StatelessWidget {
  const CartIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cart = SizedBox(
      width: 50,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: IconButton(
              color: Colors.black,
              onPressed: () {
                Get.to(() => Cart());
              },
              icon: const Icon(Boxicons.bx_cart),
            ),
          ),
          Positioned(
            top: 12,
            right: 9,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: 7,
              child: Obx(
                () => Text(
                  _databaseController.cart.length.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return cart;
  }
}
