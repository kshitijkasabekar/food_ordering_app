import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/food_item.dart';

class FoodService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  Future<List<FoodItem>> fetchFoodItems() async {
    final url = Uri.parse('$baseUrl/food-items/');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results.map((item) => FoodItem.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load food items');
    }
  }
}