class OrderDetails {
  final String id;
  final double total;
  final String status;
  final String createdAt;
  final List<OrderItem> items;

  OrderDetails({
    required this.id,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.items,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      id: json['id'],
      total: double.parse(json['total']),
      status: json['status'],
      createdAt: json['createdAt'],
      items: (json['items'] as List)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
    );
  }
}

class OrderItem {
  final String id;
  final String name;
  final double price;
  final int quantity;

  OrderItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      name: json['food']['name'],
      price: double.parse(json['food']['price']),
      quantity: json['quantity'],
    );
  }
}