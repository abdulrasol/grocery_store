import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';

class FavCard extends StatelessWidget {
  const FavCard(
      {Key? key,
      required this.itemName,
      required this.image,
      required this.price})
      : super(key: key);
  final String itemName, image;
  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 80,
                child: Image.memory(base64Decode(image)),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  sizedBox,
                  Text('$price\$'),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 80,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      color: color,
                      icon: const Icon(Icons.shopping_cart),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      color: color,
                      icon: const Icon(Icons.delete),
                    ),
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
