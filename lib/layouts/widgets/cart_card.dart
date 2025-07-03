import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/models/cart_item.dart';
import 'package:grocery_store/services/database_dontroller.dart';

// ignore: must_be_immutable
class ItemCartCard extends StatefulWidget {
  ItemCartCard({Key? key, required this.item}) : super(key: key);
  CartItem item;

  @override
  State<ItemCartCard> createState() => _ItemCartCardState();
}

class _ItemCartCardState extends State<ItemCartCard> {
  final sizebox = const SizedBox(width: 10);
  final DatabaseController controller = Get.find();
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 40,
                  child: Image.memory(base64Decode(widget.item.item.image)),
                ),
                sizebox,
                Text(
                  widget.item.item.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                sizebox,
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.item.item.price}\$',
                          style: const TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'per ${widget.item.item.sellUnit}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700]!,
                          ),
                        )
                      ],
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Form(
              child: UpdateCount(item: widget.item),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UpdateCount extends StatefulWidget {
  UpdateCount({Key? key, required this.item}) : super(key: key);

  CartItem item;

  @override
  _UpdateCountState createState() => _UpdateCountState();
}

class _UpdateCountState extends State<UpdateCount> {
  final DatabaseController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            controller.calculateItemPrice();
            setState(() {
              widget.item.quantity =
                  widget.item.quantity + widget.item.item.increaseAmount;
            });
            controller.updateCartTotalPrice();
          },
          icon: const Icon(Boxicons.bx_plus_circle),
        ),
        Text(
          '${widget.item.quantity}kg',
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (widget.item.quantity > widget.item.item.increaseAmount) {
                widget.item.quantity =
                    widget.item.quantity - widget.item.item.increaseAmount;
              }
              controller.updateCartTotalPrice();
            });
          },
          icon: const Icon(Boxicons.bx_minus_circle),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                color: Colors.black,
                onPressed: () async {
                  await controller.deleteCartItem(widget.item.id);
                },
                icon: const Icon(CupertinoIcons.delete),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
