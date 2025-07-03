import 'package:grocery_store/models/item.dart';

class QueryItem {
  final List<Item> items;

  QueryItem({required this.items});

  List<Item> getInStockItems() {
    return items.where((element) {
      if (element.availability) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Item> getItemsByCategory(String category) {
    return items.where((element) {
      if (element.category == category) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Item> getStandardItems() {
    return items.where((element) {
      if (element.priority == 1) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }

  List<Item> getSearchedItems(String query) {
    return items.where((element) {
      if (element.name.toLowerCase().contains(query.toLowerCase())) {
        return true;
      } else {
        return false;
      }
    }).toList();
  }
}
