class Order {
  final String id;
  final double total;
  final String status;
  final String createdAt;

  Order({
    required this.id,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      total: double.parse(json['total']),
      status: json['status'],
      createdAt: json['createdAt'],
    );
  }
}