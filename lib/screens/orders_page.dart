import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final OrderService _orderService = OrderService();

  late Future<List<Order>> _ordersFuture;

  @override
  void initState() {
    super.initState();
    _ordersFuture = _orderService.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      ),
      body: FutureBuilder<List<Order>>(
        future: _ordersFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(
              child: Text("No orders yet"),
            );
          }

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {

              final order = orders[index];

              return Card(
                margin: const EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// Order ID
                      Text(
                        "Order #${order.id}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      /// Total
                      Text("Total: ₹${order.total}"),

                      const SizedBox(height: 4),

                      /// Status
                      Text("Status: ${order.status}"),

                      const SizedBox(height: 4),

                      /// Date
                      Text("Placed on: ${order.createdAt}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}