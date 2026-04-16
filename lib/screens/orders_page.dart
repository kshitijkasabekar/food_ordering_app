import 'package:flutter/material.dart';
import '../services/order_service.dart';
import '../models/order.dart';
import 'order_details_page.dart';

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
    _loadOrders();
  }

  void _loadOrders() {
    _ordersFuture = _orderService.fetchOrders();
  }

  Future<void> _refreshOrders() async {
    setState(() {
      _loadOrders();
    });
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case "DELIVERED":
        return Colors.green;
      case "PLACED":
        return Colors.orange;
      case "CANCELLED":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _timeAgo(String rawDate) {
    final date = DateTime.parse(rawDate);
    final diff = DateTime.now().difference(date);

    if (diff.inDays > 0) return "${diff.inDays} day(s) ago";
    if (diff.inHours > 0) return "${diff.inHours} hour(s) ago";
    if (diff.inMinutes > 0) return "${diff.inMinutes} min ago";
    return "Just now";
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
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return const Center(child: Text("No orders yet"));
          }

          return RefreshIndicator(
            onRefresh: _refreshOrders,
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: orders.length,
              itemBuilder: (context, index) {

                final order = orders[index];
                final statusColor = _getStatusColor(order.status);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.black.withOpacity(0.05),
                      )
                    ],
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              OrderDetailsPage(orderId: order.id),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          /// Top Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Order #${order.id.substring(0, 6)}",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                order.status,
                                style: TextStyle(
                                  color: statusColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// Time
                          Text(
                            _timeAgo(order.createdAt),
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// Items preview (mock for now)
                          const Text(
                            "Veg Fried Rice, Paneer Tikka",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),

                          const SizedBox(height: 12),

                          const Divider(),

                          const SizedBox(height: 8),

                          /// Bottom Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              /// Total
                              Text(
                                "₹${order.total}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              /// CTA
                              Row(
                                children: const [
                                  Text(
                                    "View Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.arrow_forward_ios, size: 14),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}