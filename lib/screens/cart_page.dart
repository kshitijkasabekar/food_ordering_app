import 'package:flutter/material.dart';
import '../services/cart_service.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    final cartService = CartService();
    final cartItems = cartService.cartItems;

    double totalAmount = 0;
    for (var item in cartItems) {
      totalAmount += item.food.price * item.quantity;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),

      body: cartItems.isEmpty
          ? const Center(
              child: Text("Cart is empty"),
            )
          : ListView.builder(
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
                    "₹${food.price * item.quantity}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            bottomNavigationBar: cartItems.isEmpty
            ? null
            : Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Total Text
                    Text(
                      "Total: ₹${totalAmount.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// Checkout Button
                    ElevatedButton(
                      onPressed: () {
                        // Next step later
                      },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
    );
  }
}