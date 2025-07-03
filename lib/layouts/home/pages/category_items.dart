import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/cart_icon.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/layouts/widgets/item_card.dart';
import 'package:grocery_store/layouts/widgets/search.dart';
import 'package:grocery_store/models/item.dart';
import 'package:grocery_store/services/database.dart';

class CategoryItems extends StatelessWidget {
  CategoryItems({Key? key, required this.id, required this.title})
      : super(key: key);
  final String id;
  final String title;
  final DatabaseController _databaseController = Get.put(DatabaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: color,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        actions: [
          //const CartIcon(),
          IconButton(
            color: Colors.black,
            onPressed: () {
              showSearch(context: context, delegate: Search());
            },
            icon: const Icon(Boxicons.bx_search_alt),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: pageTitle(title),
            ),
            sizedBox,
            FutureBuilder(
                future: _databaseController.getCatergoryItem(id),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.hasData) {
                    return Wrap(
                      direction: Axis.horizontal,
                      spacing: 5,
                      runSpacing: 5,
                      runAlignment: WrapAlignment.start,
                      children: snapshot.data!
                          .map(
                            (item) => ItemCard(
                              item: Item(
                                  id: item["id"].toString(),
                                  name: item["name"],
                                  availability: item['in_stock'],
                                  sellUnit: 'Unit',
                                  increaseAmount: 1,
                                  category: item['categories'][0]['name'],
                                  priority: item['featured'],
                                  note: item['description']
                                      .toString()
                                      .replaceAll('<p>', '')
                                      .replaceAll('</p>', '\n'),
                                  price: double.parse(item["price"]),
                                  image: item["images"][0]["src"]),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ],
        ),
      ),
    );
  }
}
