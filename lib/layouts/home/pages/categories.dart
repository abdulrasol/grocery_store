import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/category_card.dart';
import 'package:grocery_store/layouts/widgets/category_loading_card.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/services/database.dart';

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);
  final DatabaseController _databaseController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: pageTitle('Categories'),
          ),
          sizedBox,
          _databaseController.obx(
              (state) => Wrap(
                    direction: Axis.horizontal,
                    spacing: 5,
                    runSpacing: 5,
                    children: _databaseController.categories.map((category) {
                      return CategoryCard(
                        category: category['name'],
                        image: category['image']['src'],
                        short: '',
                        id: category['id'].toString(),
                      );
                    }).toList(),
                  ),
              onLoading: Wrap(
                children: const [
                  CategoryShimmerCard(),
                  CategoryShimmerCard(),
                  CategoryShimmerCard(),
                ],
              )),
          /* FutureBuilder(
            future: getCategories(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                snapshot.data!.removeLast();

                return Wrap(
                  direction: Axis.horizontal,
                  spacing: 5,
                  runSpacing: 5,
                  children: snapshot.data!.map((category) {
                    return CategoryCard(
                      category: category['name'],
                      image: category['image']['src'],
                      short: '',
                    );
                  }).toList(),
                );
              } else {
                return ;
              }
            },
          ),*/
        ],
      ),
    );
  }
}
