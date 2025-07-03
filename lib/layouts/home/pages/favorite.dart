import 'package:flutter/material.dart';
import 'package:grocery_store/layouts/widgets/fav_card.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 3),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            sizedBox,
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: pageTitle('Favorites'),
            ),
            sizedBox,
            const FavCard(
              itemName: 'Tomato',
              image: 'assets/images/items/001-tomato.png',
              price: 18,
            ),
            const FavCard(
              itemName: 'Apple',
              image: 'assets/images/items/003-apple.png',
              price: 2,
            ),
            const FavCard(
              itemName: 'Fish',
              image: 'assets/images/items/010-fish.png',
              price: 18,
            ),
          ],
        ),
      ),
    );
  }
}
