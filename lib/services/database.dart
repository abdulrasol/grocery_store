import 'package:get/get.dart';
import '../models/item.dart';
import 'package:woocommerce_api/woocommerce_api.dart';

class DatabaseController extends GetxController with StateMixin {
  final WooCommerceAPI _wooCommerceAPI = WooCommerceAPI(
      url: "http://dotit.tech",
      // consumerKey: "ck_ce06461b371bc08f75dfae0640156e25a9ffedc9",
      consumerKey: 'ck_68df334e480283d6aa0cda2557433d6fd55a5168',
      //consumerSecret: "cs_33a65cf8ffc70f6aee055ec9e072e988968756ad");
      consumerSecret: "cs_4157aa09a1ec847a0ddb996b6cbf2cdce1828962");

  // start get all products
  late Rx<List<Item>> products;
  Future<List<Item>> getProducts() async {
    // Get data using the "products" endpoint
    change(state, status: RxStatus.loading());
    var data = await _wooCommerceAPI.getAsync("products");
    change(state, status: RxStatus.success());
    return getItemsFromQuery(data);
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
          note: item['description']
              .toString()
              .replaceAll('<p>', '')
              .replaceAll('</p>', '\n'),
          price: double.parse(item["price"]),
          image: item["images"][0]["src"]);
    }).toList();
  }

  // end get all products
  //---------------------------
  // start get categories
  List categories = [].obs;
  Future<List> getCategories() async {
    change(state, status: RxStatus.loading());
    var cats = await _wooCommerceAPI.getAsync('products/categories');
    //await _wooCommerceAPI.postAsync('/wc-auth/v1/authorize', {});
    cats.removeLast();
    print(cats[0]['id']);
    change(state, status: RxStatus.success());
    return cats;
  }

  // get category items

  Future<List> getCatergoryItem(id) async {
    var items = await _wooCommerceAPI.getAsync('products/?category=$id');
    return items;
  }

  // end get categories
  //---------------------------
  // start get categories

  // end get all categories
  //---------------------------
  // start user info and auth

  // user
  var user = {
    'name': '',
  }.obs;

  // end user info and auth
  @override
  void onInit() async {
    products = Rx(await getProducts());
    categories = await getCategories();
    super.onInit();
  }
}
