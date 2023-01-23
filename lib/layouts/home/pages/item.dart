import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/cart_icon.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/models/item.dart' as modules;
import 'cart.dart';

double quantity = 1;

// ignore: must_be_immutable
class Item extends StatelessWidget {
  Item({Key? key, required this.item}) : super(key: key);
  final modules.Item item;

  double? price;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          item.name,
          style: const TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            quantity = 1;
            Get.back();
          },
        ),
        actions: const [CartIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width,
                        child: Image.network(item.image),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          sizedBox,
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${item.price}\$',
                                  style: const TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'per ${item.sellUnit}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700]!,
                                  ),
                                )
                              ],
                            ),
                          ),
                          sizedBox,
                          UpdateCount(item: item, quantity: quantity),
                          sizedBox,
                          Text(
                            item.note,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 70),
                    ],
                  ),
                )),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
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
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(text: 'Total Price '),
                            TextSpan(
                                text:
                                    '${(item.price * quantity).toStringAsFixed(2)}\$')
                          ],
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Expanded(child: sizedBox),
                      TextButton.icon(
                        onPressed: () async {
                          /*  await _controller.addItemToCart(
                              item: item, quantity: quantity);
                          quantity = 1; */
                          showSnackbar(
                            'Cart',
                            '${item.name} added to cart',
                            item.image,
                            mainButton: TextButton(
                              onPressed: () => Get.to(() => Cart()),
                              child: const Text('View Cart'),
                            ),
                          );
                        },
                        label: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        icon: const Icon(
                          Boxicons.bx_cart_alt,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class UpdateCount extends StatefulWidget {
  UpdateCount({Key? key, required this.item, required this.quantity})
      : super(key: key);
  final modules.Item item;
  double quantity;

  @override
  _UpdateCountState createState() => _UpdateCountState();
}

class _UpdateCountState extends State<UpdateCount> {
  double? price;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              quantity = quantity + widget.item.increaseAmount;
            });
          },
          icon: const Icon(Boxicons.bx_plus_circle),
        ),
        Text(
          '$quantity kg',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (quantity > widget.item.increaseAmount) {
                quantity = quantity - widget.item.increaseAmount;
              }
            });
          },
          icon: const Icon(Boxicons.bx_minus_circle),
        ),
      ],
    );
  }
}
