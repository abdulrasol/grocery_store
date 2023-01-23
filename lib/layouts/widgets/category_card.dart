import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:grocery_store/services/database.dart';

import '../home/pages/category_items.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard({
    Key? key,
    required this.category,
    required this.image,
    required this.short,
    required this.id,
  }) : super(key: key);
  final String category, image, short, id;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Get.to(() => CategoryItems(
                title: category,
                id: id,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 250,
            width: 150,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, image) => Container(
                        child:
                            const Center(child: CircularProgressIndicator())),
                    errorWidget: (context, image, error) =>
                        const Icon(Icons.error),
                  ),
                  /* Image.network(
                    image,
                    fit: BoxFit.contain,
                  ), */
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: [
                        Text(
                          category,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(short)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
