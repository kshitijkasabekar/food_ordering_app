import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/cart_item.dart';
import 'token_service.dart';

class CartService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  final TokenService _tokenService = TokenService();

  Future<List<CartItem>> fetchCartItems() async {
    final token = await _tokenService.getAccessToken();

    final url = Uri.parse('$baseUrl/cart/');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results.map((item) => CartItem.fromJson(item)).toList();
    } else {
      throw Exception("Failed to load cart items");
    }
  }