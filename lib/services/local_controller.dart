import 'package:get/get.dart';

class LocalController extends GetxController with StateMixin {
  // home page
  var selectedHomePage = 0.obs;
  var userImgae = ''.obs;
  setSelectedHomePage(int index) {
    selectedHomePage.value = index;
  }
}


/*
 Rx<QueryItem> itemsoffline = QueryItem(items: [
    Item(
      id: 'id1',
      name: 'Tomato',
      availability: true,
      sellUnit: 'Kilogram',
      category: 'vegetables',
      note: 'Ipsum sed dolorem aspernatur qui fugiat aut.',
      price: 1.2,
      image: 'assets/images/items/001-tomato.png',
      priority: 1,
    ),
    Item(
      id: 'id2',
      name: 'Onion',
      availability: true,
      sellUnit: 'Kilogram',
      category: 'vegetables',
      note: 'Ipsum sed dolorem aspernatur qui fugiat aut.',
      price: 1,
      image: 'assets/images/items/013-onion.png',
      priority: 1,
    ),
    Item(
      id: 'id2',
      name: 'Potato',
      availability: true,
      sellUnit: 'Kilogram',
      category: 'vegetables',
      note: 'Ipsum sed dolorem aspernatur qui fugiat aut.',
      price: 0.75,
      image: 'assets/images/items/011-potato.png',
      priority: 1,
    ),
    Item(
      id: 'id4',
      name: 'Apple',
      availability: true,
      sellUnit: 'Kilogram',
      category: 'fruits',
      note: 'Ipsum sed dolorem aspernatur qui fugiat aut.',
      price: 1.2,
      image: 'assets/images/items/003-apple.png',
      priority: 1,
    ),
  ]).obs;
 */