import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:grocery_store/layouts/widgets/item_card.dart';
import 'package:grocery_store/layouts/widgets/item_card_loading.dart';
import 'package:grocery_store/services/database.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:convert';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final DatabaseController _databaseController = Get.put(DatabaseController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Silder Carousel
            FutureBuilder(
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                    items: snapshot.data!
                        .map(
                          (item) => Builder(
                            builder: (context) {
                              return InkWell(
                                onTap: () {},
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    margin: const EdgeInsets.all(5),
                                    child: Image.memory(
                                      base64Decode(item),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return CarouselSlider(
                    options: CarouselOptions(
                      height: 180.0,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                    ),
                    items: [1, 2, 3]
                        .map(
                          (item) => Builder(
                            builder: (context) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[200]!,
                                highlightColor: Colors.white,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Card(
                                    margin: EdgeInsets.all(5),
                                    child: SizedBox(),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                        .toList(),
                  );
                }
              },
            ),
            // cat 1
            sizedBox,
            subtitleText('Essentials of cooking'),

            SizedBox(
              height: 260,
              child: _databaseController.obx(
                (state) => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _databaseController.products.value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ItemCard(
                        item: _databaseController.products.value[index]);
                  },
                ),
                onLoading: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (_, __) => const ItemShimmerCard()),
              ),
            ),

            sizedBox,
          ],
        ),
      ),
    );
  }
}
