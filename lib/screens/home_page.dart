import 'package:flutter/material.dart';
import '../services/food_service.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FoodService _foodService = FoodService();
  final CartService _cartService = CartService();

  List<FoodItem> _foods = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFoods();
  }

  Future<void> _loadFoods() async {
    try {
      final foods = await _foodService.fetchFoodItems();

      if (!mounted) return;

      setState(() {
        _foods = foods;
        _isLoading = false;
      });

    } catch (e) {

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading foods: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Food Items"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartPage()),
                  ).then((_) => setState(() {}));
                },
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart),

                    const SizedBox(width: 4),

                    Text(
                      _cartService.totalItems.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _foods.length,
        itemBuilder: (context, index) {
          final food = _foods[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Price
                  Text(
                    "₹${food.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  /// ADD Button
                  ElevatedButton(
                    onPressed: () async {
                      final messenger = ScaffoldMessenger.of(context);
                      await _cartService.addToCart(food);
                      if (!mounted) return;
                      setState(() {
                        // trigger rebuild
                      });
                      messenger.showSnackBar(
                        SnackBar(content: Text('${food.name} added to cart')),
                      );
                    },
                    child: const Text("ADD"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}