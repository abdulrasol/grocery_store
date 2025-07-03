import 'package:grocery_store/models/item.dart';

class CartItem {
  CartItem({required this.item, required this.quantity, required this.id});

  final Item item;
  double quantity;
  final String id;

  CartItem.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id']! as String,
          quantity: map['quantity']! as double,
          item: map['itme']! as Item,
        );

  Map<String, dynamic> toJson() {
    return {
      'item': Item,
      'quantity': quantity,
    };
  }
}
