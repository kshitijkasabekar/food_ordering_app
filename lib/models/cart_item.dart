import 'food_item.dart';

class CartItem {
  final FoodItem food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      food: FoodItem.fromJson(json['food']),
      quantity: json['quantity'],
    );
  }
}