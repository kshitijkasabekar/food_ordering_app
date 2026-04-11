import 'food_item.dart';

class CartItem {
  final String id;
  final FoodItem food;
  final int quantity;

  CartItem({
    required this.id,
    required this.food,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      food: FoodItem.fromJson(json['food']),
      quantity: json['quantity'],
    );
  }
}