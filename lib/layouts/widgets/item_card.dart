import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/models/item.dart' as models;
import 'package:get/get.dart';
import '../home/pages/item.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  final models.Item item;

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
      child: InkWell(
        onTap: () {
          Get.to(
            () => (Item(
              item: item,
            )),
          );
        },
        child: SizedBox(
          height: 260,
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 134,
                  height: 100,
                  child: SizedBox(
                    width: 100,
                    child: Image.network(
                      item.image,
                    ), //Image.memory(base64Decode(item.image)),
                  ),
                ),
                sizedBox,
                Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  '\$${item.price}/${item.sellUnit}',
                  style: const TextStyle(color: Colors.black38),
                ),
                sizedBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.price.toString()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(color),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        elevation: MaterialStateProperty.all(2),
                        minimumSize:
                            MaterialStateProperty.all(const Size(40, 40)),
                        maximumSize:
                            MaterialStateProperty.all(const Size(40, 40)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                      ),
                      onPressed: () async {
                        showSnackbar(
                          'Cart',
                          '${item.name} added to cart',
                          item.image,
                          mainButton: TextButton(
                            onPressed: () {/* Get.to(() => Cart()) */},
                            child: const Text('View Cart'),
                          ),
                        );
                      },
                      child: const Center(child: Icon(Boxicons.bx_plus)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
