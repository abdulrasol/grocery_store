import 'package:grocery_store/models/cart_item.dart';

class Order {
  Order({
    this.items,
    required this.user,
    this.id,
    this.userState,
    this.storeState,
    this.location,
    this.price,
    this.date,
  });

  List<CartItem>? items;
  final String user;
  String? date;
  String? id;
  String? userState;
  String? storeState;
  List? location;
  double? price;

  Order.fromJson(Map<String, dynamic> map)
      : this(
          id: map['id']! as String,
          user: map['user']! as String,
          items: map['itme']! as List<CartItem>,
          userState: map['userState'] as String,
          storeState: map['storeState'] as String,
          location: map['loction'] as List,
          price: map['price'] as double,
          date: map['date'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'items': [],
      'user': user,
      'userState': userState,
      'storeState': storeState,
      'price': price,
      'date': date,
    };
  }
}
