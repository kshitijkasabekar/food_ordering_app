import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_service.dart';
import '../models/order.dart';

class OrderService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  final TokenService _tokenService = TokenService();

  Future<void> placeOrder() async {
    final token = await _tokenService.getAccessToken();

    if (token == null) {
      throw Exception("User not authenticated");
    }

    final url = Uri.parse('$baseUrl/orders/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to place order: ${response.body}');
    }
  }

  Future<List<Order>> fetchOrders() async {
    final token = await _tokenService.getAccessToken();

    if (token == null) {
      throw Exception("User not authenticated");
    }

    final url = Uri.parse('$baseUrl/orders/');

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

      return results.map((e) => Order.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch orders');
    }
  }
}