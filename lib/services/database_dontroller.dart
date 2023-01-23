/*
* Auther: @abdulrasol 
*/

import 'dart:async';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grocery_store/models/cart_item.dart';
import 'package:grocery_store/models/category.dart';
import 'package:grocery_store/models/item.dart';
import 'package:grocery_store/models/order.dart';
import 'package:grocery_store/models/query.dart';
import 'package:grocery_store/models/user.dart' as models;

import 'package:woocommerce_api/woocommerce_api.dart';

final WooCommerceAPI _wooCommerceAPI = WooCommerceAPI(
    url: "http://localhost/store",
    consumerKey: "ck_ce06461b371bc08f75dfae0640156e25a9ffedc9",
    consumerSecret: "cs_33a65cf8ffc70f6aee055ec9e072e988968756ad");

// get all products
Future<List> getProducts() async {
  // Get data using the "products" endpoint
  return getItemsFromQuery(await _wooCommerceAPI.getAsync("products"));
}

// get all cat
Future<List> getCategories() async {
  // Get data using the "products" endpoint
  List categories = await _wooCommerceAPI.getAsync('products/categories');

  return categories;
  //return getItemsFromQuery(await _wooCommerceAPI.getAsync("products"));
}

List<Category> getCatFormQuery(List query) {
  return query.map((cat) {
    return Category(
        name: cat['name'],
        image: cat['image']['src'],
        description: 'description');
  }).toList();
}

List<Item> getItemsFromQuery(List query) {
  return query.map((item) {
    return Item(
        id: item["id"].toString(),
        name: item["name"],
        availability: item['in_stock'],
        sellUnit: 'Unit',
        increaseAmount: 1,
        category: item['categories'][0]['name'],
        priority: item['featured'],
        note: 'note',
        price: double.parse(item["price"]),
        image: item["images"][0]["src"]);
  }).toList();
}

class DatabaseController extends GetxController with StateMixin {
  ///
  /// get all items in stores
  ///
  late Rx<List<Item>> products;
  // get all products
  Future<List<Item>> getProducts() async {
    // Get data using the "products" endpoint
    return getItemsFromQuery(await _wooCommerceAPI.getAsync("products"));
  }

  /// shiping cost for all orders
  late final double shopingCost;

  /// firebase users collections path
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  /// current user id
  final uid = '00000';

  /// current user
  late final Rx<models.User> user;
  Future initUserInfo() async {
    // to fetch user data
    await _users.doc(uid).set({
      'name': 'test',
    });
  }

  /// get user as stream
  Stream<models.User> get _getUserInfo {
    return _users
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot<Object?> userData) {
      Map<String, dynamic> userDataMap =
          userData.data() as Map<String, dynamic>;
      return models.User(
        id: userData.id,
        name: userDataMap['name'] ?? '',
        location: userDataMap['location'] ?? ['', const GeoPoint(0, 0)],
        orders: userDataMap['orders'] ?? [],
        email: userDataMap['email'] ?? '',
      );
      // }
    });
  }

  /// firebase items collections path
  final CollectionReference _items =
      FirebaseFirestore.instance.collection('items');

  /// store items
  final items = <Item>[].obs;
  late final Rx<QueryItem> query;

  /// await fetch items
  Future<QueryItem> getAllItem() async {
    // to change state to loading
    change(null, status: RxStatus.loading());
    var a = await _items.get();
    // to change state to done
    change(null, status: RxStatus.success());
    return QueryItem(
      items: a.docs.map((DocumentSnapshot e) {
        Map<String, dynamic> item = e.data() as Map<String, dynamic>;
        item['id'] = e.id;
        return Item(
            id: e.id,
            name: item['name'],
            availability: item['availability'],
            sellUnit: item['sellUnit'],
            increaseAmount: double.parse(item['increaseAmount'].toString()),
            category: item['category'],
            priority: item['priority'],
            note: item['note'],
            price: double.parse(item['price'].toString()),
            image: item['image']);
      }).toList(),
    );
  }

  /// firebase categories collections path
  final CollectionReference _categories =
      FirebaseFirestore.instance.collection('categories');

  /// categories list
  late final Rx<List<Category>> categories;

  // to fetch categories from QuerySnapshot
  List<Category> _getCatergories(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((category) {
      return Category(
        name: category['name'],
        image: category['image'],
        description: category['description'],
      );
    }).toList();
  }

  // to fetch categories from firebase DB
  Future<List<Category>> getCatergories() async {
    return _getCatergories(
        await _categories.get() as QuerySnapshot<Map<String, dynamic>>);
  }

  /// firebase cards collections path
  final CollectionReference _cards =
      FirebaseFirestore.instance.collection('slides');

  /// home silde cards
  late final Rx<List<String>> cards;

  /// to fetch  home silde cards from firebase DB
  List<String> _getStringFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((card) {
      return card['image'].toString();
    }).toList();
  }

  /// to fetch  home silde cards from firebase DB
  Future<List<String>> getCards() async {
    return _getStringFromQuerySnapshot(
        await _cards.get() as QuerySnapshot<Map<String, dynamic>>);
  }

  /// user cart path
  late final CollectionReference _cart;

  /// user cart
  final cart = <CartItem>[].obs;

  /// total pricr for current cart
  late RxDouble cartTolatPrice;

  /// to calculate total pricr for current cart
  updateCartTotalPrice() {
    cartTolatPrice.value = calculateItemPrice();
  }

  // get cart price
  double calculateItemPrice() {
    double cartPrice = 0;

    for (var element in cart) {
      cartPrice = cartPrice + (element.quantity * element.item.price);
    }
    return cartPrice;
  }

  // add item to cart
  Future addItemToCart({required Item item, required double quantity}) async {
    await _cart.add({
      'item': {
        'id': item.id,
        'name': item.name,
        'availability': item.availability,
        'sellUnit': item.sellUnit,
        'category': item.category,
        'increaseAmount': item.increaseAmount,
        'note': item.note,
        'price': item.price,
        'image': item.image,
        'priority': item.priority,
      },
      'quantity': quantity,
    });
    updateCartTotalPrice();
  }

  // delete item from cart
  Future deleteCartItem(id) async {
    await _cart.doc(id).delete();
    updateCartTotalPrice();
  }

  List<CartItem> _getQueryCartItemFromSnapshot(
      QuerySnapshot<Object?> querySnapshot) {
    return querySnapshot.docs.map((iterator) {
      final itemData = iterator.data() as Map<String, dynamic>;
      Map item = itemData['item'] as Map<String, dynamic>;
      return CartItem(
          item: Item(
            id: item['id'],
            name: item['name'],
            availability: item['availability'],
            sellUnit: item['sellUnit'],
            increaseAmount: item['increaseAmount'],
            category: item['category'],
            note: item['note'],
            price: double.parse(item['price'].toString()),
            image: item['image'],
            priority: item['priority'],
          ),
          quantity: double.parse(itemData['quantity'].toString()),
          id: iterator.id);
    }).toList();
  }

  Stream<List<CartItem>> get _cartStream =>
      _cart.snapshots().map((event) => _getQueryCartItemFromSnapshot(event));

  // Orders
  late final CollectionReference _orders;
  RxList<Order> orders = <Order>[].obs;

  Future<List<Order>> getOrders() async {
    var query = await _orders.where('user', isEqualTo: uid).get();
    return query.docs.map((element) {
      var order = element.data() as Map<String, dynamic>;
      var items = order['items'] as List;
      return Order(
        user: uid,
        id: element.id,
        userState: order['userState'],
        storeState: order['storeState'],
        price: order['price'],
        date: order['date'],
        items: items.map((element) {
          var cartItem = element as Map<String, dynamic>;
          return CartItem(
            item: Item(
              id: cartItem['id'],
              name: cartItem['name'],
              availability: cartItem['availability'],
              sellUnit: cartItem['sellUnit'],
              increaseAmount:
                  double.parse(cartItem['increaseAmount'].toString()),
              category: "item['category']",
              priority: cartItem['priority'],
              note: cartItem['note'],
              price: double.parse(cartItem['increaseAmount'].toString()),
              image: cartItem['image'],
            ),
            quantity: cartItem['quantity'],
            id: cartItem['id'],
          );
        }).toList(),
      );
    }).toList();
  }

  Future<Order> confirmOrder(Order order) async {
    String date =
        '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
    final item = await _orders.add({
      'date': date,
      'user': order.user,
      'userState': 'wating',
      'storeState': 'preparing',
      'location': order.location,
      'price': order.price,
      'items': cart
          .map((item) => {
                'id': item.item.id,
                'name': item.item.name,
                'availability': item.item.availability,
                'sellUnit': item.item.sellUnit,
                'increaseAmount': item.item.increaseAmount,
                'category': item.item.category,
                'note': item.item.note,
                'price': item.item.price,
                'image': item.item.image,
                'priority': item.item.priority,
                'quantity': item.quantity,
              })
          .toList(),
    });

    order.id = item.id;
    order.date = date;
    order.storeState = 'preparing';
    order.userState = 'wating';
    order.items = cart.toList();
    for (var item in cart) {
      deleteCartItem(item.id);
    }
    return order;
  }

  @override
  void onInit() async {
    user = models.User(id: uid).obs;
    user.bindStream(_getUserInfo);
    _cart = FirebaseFirestore.instance.collection('users/$uid/cart');
    _orders = FirebaseFirestore.instance.collection('/orders');
    cart.bindStream(_cartStream);

    query = (await getAllItem()).obs;
    cartTolatPrice = calculateItemPrice().obs;

    //

    products = Rx(await getProducts());

    super.onInit();
  }
}
