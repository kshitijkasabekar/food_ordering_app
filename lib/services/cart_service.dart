import 'dart:convert';
import 'package:food_ordering_app/services/token_service.dart';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import '../models/food_item.dart';

class CartService {
  static final CartService _instance = CartService._internal();
  static const String baseUrl = 'http://10.0.2.2:8000';

  factory CartService() {
    return _instance;
  }

  CartService._internal();

  final List<CartItem> _cartItems = [];
  final TokenService _tokenService = TokenService();

  List<CartItem> get cartItems => _cartItems;

  int get totalItems {
    int total = 0;

    for (var item in _cartItems) {
      total += item.quantity;
    }

    return total;
  }

  Future<void> addToCart(FoodItem food) async {
    final token = await _tokenService.getAccessToken();
    if (token == null) {
      throw Exception("User not authenticated");
    }

    final url = Uri.parse('$baseUrl/cart-items/');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'foodId': food.id,
        'quantity': 1,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(
        'Failed to add item to cart (${response.statusCode}): ${response.body}',
      );
    }
  }

  Future<void> increaseQuantity(String cartItemId, int currentQty) async {
    final token = await _tokenService.getAccessToken();

    if (token == null) {
      throw Exception("User not authenticated");
    }

    final url = Uri.parse('$baseUrl/cart-items/$cartItemId/');

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'quantity': currentQty + 1,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update quantity');
    }
  }

  Future<void> decreaseQuantity(String cartItemId, int currentQty) async {
    final token = await _tokenService.getAccessToken();

    if (token == null) {
      throw Exception("User not authenticated");
    }

    final url = Uri.parse('$baseUrl/cart-items/$cartItemId/');

    if (currentQty > 1) {
      final response = await http.patch(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'quantity': currentQty - 1,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update quantity');
      }
    } else {
      /// Remove item if quantity = 1
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode != 204 && response.statusCode != 200) {
        throw Exception('Failed to remove item');
      }
    }
  }

  void clearCart() {
    _cartItems.clear();
  }

  Future<List<CartItem>> fetchCartItems() async {
    final token = await _tokenService.getAccessToken();

    if (token == null) {
      throw Exception("User not authenticated");
    }

    final url = Uri.parse('$baseUrl/cart-items/');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to fetch cart items');
    }
  }
}