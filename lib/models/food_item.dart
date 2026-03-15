class FoodItem {
  final String id;
  final String restaurantId;
  final String name;
  final String description;
  final double price;

  FoodItem({
    required this.id,
    required this.restaurantId,
    required this.name,
    required this.description,
    required this.price,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      restaurantId: json['restaurantId'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
    );
  }
}