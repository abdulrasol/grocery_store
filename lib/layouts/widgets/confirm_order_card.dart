import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_store/models/cart_item.dart';

class ConfiemOrderItemCard extends StatelessWidget {
  const ConfiemOrderItemCard({Key? key, required this.elememt})
      : super(key: key);
  final CartItem elememt;

  @override
  Widget build(BuildContext context) {
    double price = elememt.item.price * elememt.quantity;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          width: 1,
          color: Colors.grey[300]!,
        ),
      ),
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2.5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Image.memory(
                base64Decode(elememt.item.image),
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  elememt.item.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${price.toStringAsFixed(2)}\$ for ${elememt.quantity} ${elememt.item.sellUnit}',
                  style: const TextStyle(
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
