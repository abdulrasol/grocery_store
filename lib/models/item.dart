class Item {
  final String id;
  final String name;
  final bool availability;
  final String sellUnit;
  final String category;
  final String note;
  final String image;
  final double price;
  final bool priority;
  final double increaseAmount;

  Item({
    required this.id,
    required this.name,
    required this.availability,
    required this.sellUnit,
    required this.increaseAmount,
    required this.category,
    required this.priority,
    required this.note,
    required this.price,
    required this.image,
  });

  Item.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id']! as String,
          name: json['name']! as String,
          availability: json['availability']! as bool,
          sellUnit: json['sellUnit']! as String,
          increaseAmount: json['increaseAmount'] as double,
          category: json['category']! as String,
          priority: json['priority']! as bool,
          note: json['note']! as String,
          price: json['price']! as double,
          image: json['image']! as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'availability': availability,
      'sellUnit': sellUnit,
      'category': category,
      'price': price,
      'note': note,
      'image': image,
    };
  }
}
