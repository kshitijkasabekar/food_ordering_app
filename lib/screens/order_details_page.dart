import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order_details.dart';

class OrderDetailsPage extends StatefulWidget {
  final String orderId;

  const OrderDetailsPage({super.key, required this.orderId});

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final OrderService _orderService = OrderService();

  late Future<OrderDetails> _orderFuture;

  @override
  void initState() {
    super.initState();
    _orderFuture = _orderService.fetchOrderDetails(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Details"),
      ),
      body: FutureBuilder<OrderDetails>(
        future: _orderFuture,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final order = snapshot.data!;

          return Column(
            children: [

              /// Order Info
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Order #${order.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text("Status: ${order.status}"),

                    const SizedBox(height: 4),

                    Text("Placed on: ${order.createdAt}"),
                  ],
                ),
              ),

              const Divider(),

              /// Items
              Expanded(
                child: ListView.builder(
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {

                    final item = order.items[index];

                    return ListTile(
                      title: Text(item.name),

                      subtitle: Text(
                        "Qty: ${item.quantity} • ₹${item.price}",
                      ),

                      trailing: Text(
                        "₹${(item.price * item.quantity).toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),

              /// Total
              Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Total: ₹${order.total}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}