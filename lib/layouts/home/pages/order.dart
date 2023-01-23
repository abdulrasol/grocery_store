import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/home/home_warper.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/models/order.dart' as models;

// ignore: must_be_immutable
class Order extends StatelessWidget {
  Order({
    Key? key,
    required this.order,
    required this.formChechout,
  }) : super(key: key);
  final models.Order order;
  double totalPrice = 0;
  final bool formChechout;

  @override
  Widget build(BuildContext context) {
    bool isComplete = (order.storeState == 'done' && order.userState == 'done');
    String state = 'delevring';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            if (formChechout) {
              Get.off(() => HomeWarper());
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Date: ${order.date}',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Text(
                  'Price: ${order.price!.toStringAsFixed(2)} \$',
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            sizedBox,
            Expanded(
              child: ListView(
                children: order.items!
                    .map(
                      (item) => Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                            width: 1,
                            color: Colors.grey[300]!,
                          ),
                        ),
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 2.5),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 50,
                                child: Image.memory(
                                  base64Decode(item.item.image),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.item.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${item.item.price}\$ for ${item.quantity} ${item.item.sellUnit}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.black87,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
                child: Row(
                  children: [
                    const Text(
                      'State ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    isComplete
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : Text(
                            state,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
