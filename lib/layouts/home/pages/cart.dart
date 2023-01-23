import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/pages/confirm_order.dart';
import 'package:grocery_store/layouts/widgets/cart_card.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/services/database_dontroller.dart';

class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);
  final controller = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    controller.calculateItemPrice();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: pageTitle('My Cart'),
              ),
            ),
            Positioned(
              top: 60,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 65),
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.cart.length,
                    itemBuilder: (context, index) {
                      return ItemCartCard(
                        item: controller.cart[index],
                      );
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.black87,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text(
                        'Total Price: ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Obx(() {
                        return Text(
                          // here
                          '${controller.cartTolatPrice.toStringAsFixed(2)}\$',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      OutlinedButton(
                        onPressed: () async {
                          if (controller.cart.isNotEmpty) {
                            Get.to(() => ConfirmOrder());
                          } else {
                            showSnackbar('Alert', 'Cart Empty!', 'a');
                          }
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
