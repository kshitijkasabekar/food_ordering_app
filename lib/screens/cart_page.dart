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
                  subtitle: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          cartService.decreaseQuantity(food);
                          (context as Element).markNeedsBuild();
                        },
                      ),

                      Text("${item.quantity}"),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          cartService.increaseQuantity(food);
                          (context as Element).markNeedsBuild();
                        },
                      ),
                    ],
                  ),
                  trailing: Text(
                    "₹${(food.price * item.quantity).toStringAsFixed(2)}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Order placed successfully!")),
                          );

                          final cartService = CartService();
                          cartService.clearCart();
                          Navigator.pop(context);
                        },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
    );
  }
}