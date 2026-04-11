import 'package:flutter/material.dart';
import '../services/cart_service.dart';
import '../models/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CartService cartService = CartService();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),

      body: FutureBuilder<List<CartItem>>(
        future: cartService.fetchCartItems(),
        builder: (context, snapshot) {

          /// Loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          /// Error
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final cartItems = snapshot.data ?? [];

          /// Empty cart
          if (cartItems.isEmpty) {
            return const Center(
              child: Text("Cart is empty"),
            );
          }

          /// Calculate total
          double totalAmount = 0;
          for (var item in cartItems) {
            totalAmount += item.food.price * item.quantity;
          }

          return Column(
            children: [

              /// List
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {

                    final item = cartItems[index];
                    final food = item.food;

                    return ListTile(
                      title: Text(food.name),

                      subtitle: Text(
                        "Qty: ${item.quantity} • ₹${food.price}",
                      ),

                      trailing: Text(
                        "₹${(food.price * item.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Total + Checkout
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Text(
                      "Total: ₹${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Order placed successfully!"),
                          ),
                        );

                        Navigator.pop(context);
                      },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}