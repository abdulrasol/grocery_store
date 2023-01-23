import 'package:flutter/material.dart';
import 'package:grocery_store/layouts/home/pages/categories.dart';
import 'package:grocery_store/layouts/home/pages/home.dart';
import 'package:grocery_store/layouts/widgets/final_var.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';

import 'pages/more.dart';

class HomeWarper extends StatefulWidget {
  HomeWarper({Key? key}) : super(key: key);

  @override
  State<HomeWarper> createState() => _HomeWarperState();
}

class _HomeWarperState extends State<HomeWarper> {
  int pointer = 0;
  final List<Widget> _page = [
    Home(),
    Categories(),
    Categories(),
    More(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        actions: [
          //const CartIcon(),
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: const Icon(Boxicons.bx_search_alt),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _page[pointer],
      ),
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: pointer,
        onTap: (value) {
          setState(() {
            pointer = value;
          });
        },
        items: [
          bottomBarItem(color, Boxicons.bx_home, 'Home'),
          bottomBarItem(color, Boxicons.bx_category_alt, 'Categories'),
          bottomBarItem(color, Boxicons.bx_heart, 'Favorites'),
          bottomBarItem(color, Boxicons.bx_dots_horizontal_rounded, 'More'),
        ],
        curve: Curves.decelerate,
      ),
    );
  }

  bottomBarItem(Color color, IconData icon, String title) {
    return SalomonBottomBarItem(
      selectedColor: color,
      icon: Icon(icon),
      title: Text(title),
    );
  }
}

class HomeWarper1 extends StatelessWidget {
  HomeWarper1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
