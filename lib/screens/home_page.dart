import 'package:flutter/material.dart';
import '../services/food_service.dart';
import '../models/food_item.dart';
import '../services/cart_service.dart';
import 'cart_page.dart';
import 'orders_page.dart';

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

  int _cartCount = 0;

  @override
  void initState() {
    super.initState();
    _loadFoods();
    _loadCartCount();
  }

  Future<void> _loadFoods() async {
    final messenger = ScaffoldMessenger.of(context);

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

      messenger.showSnackBar(
        SnackBar(content: Text("Error loading foods: $e")),
      );
    }
  }

  Future<void> _loadCartCount() async {
    try {
      final items = await _cartService.fetchCartItems();

      if (!mounted) return;

      int total = 0;
      for (var item in items) {
        total += item.quantity;
      }

      setState(() {
        _cartCount = total;
      });

    } catch (e) {
      // optional
    }
  }

  Future<void> _handleAddToCart(FoodItem food) async {
    final messenger = ScaffoldMessenger.of(context);

    try {
      await _cartService.addToCart(food);

      if (!mounted) return;

      await _loadCartCount(); // ✅ refresh count from API

      messenger.showSnackBar(
        SnackBar(content: Text('${food.name} added to cart')),
      );

    } catch (e) {
      if (!mounted) return;

      messenger.showSnackBar(
        SnackBar(content: Text("Error: $e")),
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

          /// Orders Button
          IconButton(
            icon: const Icon(Icons.receipt_long),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const OrdersPage(),
                ),
              );
            },
          ),

          /// Cart Button
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CartPage(),
                    ),
                  ).then((_) => _loadCartCount()); // ✅ refresh after return
                },
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart),

                    const SizedBox(width: 4),

                    Text(
                      _cartCount.toString(),
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

                  /// Food Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          food.description,
                          style: const TextStyle(color: Colors.grey),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "₹${food.price}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// ADD Button
                  ElevatedButton(
                    onPressed: () => _handleAddToCart(food),
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