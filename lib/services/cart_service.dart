import '../models/cart_item.dart';
import '../models/food_item.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  void addToCart(FoodItem food) {
    final index = _cartItems.indexWhere(
      (item) => item.food.id == food.id,
    );

    if (index != -1) {
      _cartItems[index].quantity++;
    } else {
      _cartItems.add(
        CartItem(food: food, quantity: 1),
      );
    }
  }
}