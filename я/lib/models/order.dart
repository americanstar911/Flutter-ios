class OrderLine {
  final String name;
  final String size;
  final int quantity;
  final int price;

  const OrderLine({
    required this.name,
    required this.size,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'size': size,
    'quantity': quantity,
    'price': price,
  };

  factory OrderLine.fromJson(Map<String, dynamic> j) => OrderLine(
    name: j['name'] as String,
    size: j['size'] as String,
    quantity: j['quantity'] as int,
    price: j['price'] as int,
  );
}

class Order {
  /// Для демо: один этап доставки = 15 секунд.
  static const stepSeconds = 15;

  final String id;
  final DateTime date;
  final List<OrderLine> lines;
  final String delivery;
  final int deliveryPrice;
  final int discount;
  final int total;
  final int pointsEarned;
  final String address;
  final String contact;
  final bool isPickup;
  final DateTime eta;

  const Order({
    required this.id,
    required this.date,
    required this.lines,
    required this.delivery,
    required this.deliveryPrice,
    required this.discount,
    required this.total,
    required this.pointsEarned,
    required this.address,
    required this.contact,
    required this.isPickup,
    required this.eta,
  });

  String get dateLabel {
    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(date.day)}.${two(date.month)}.${date.year}';
  }

  List<String> get steps => isPickup
      ? const ['Order placed', 'Packed', 'Ready for pickup']
      : const [
          'Order placed',
          'Packed',
          'Shipped',
          'Out for delivery',
          'Delivered',
        ];

  int stepAt(DateTime now) {
    final passed = now.difference(date).inSeconds ~/ stepSeconds;
    if (passed < 0) return 0;
    return passed >= steps.length ? steps.length - 1 : passed;
  }

  String statusAt(DateTime now) => steps[stepAt(now)];

  bool isFinishedAt(DateTime now) => stepAt(now) == steps.length - 1;

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date.toIso8601String(),
    'lines': lines.map((l) => l.toJson()).toList(),
    'delivery': delivery,
    'deliveryPrice': deliveryPrice,
    'discount': discount,
    'total': total,
    'pointsEarned': pointsEarned,
    'address': address,
    'contact': contact,
    'isPickup': isPickup,
    'eta': eta.toIso8601String(),
  };

  factory Order.fromJson(Map<String, dynamic> j) {
    final date = DateTime.parse(j['date'] as String);
    return Order(
      id: j['id'] as String,
      date: date,
      lines: (j['lines'] as List<dynamic>)
          .map((e) => OrderLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      delivery: j['delivery'] as String,
      deliveryPrice: j['deliveryPrice'] as int,
      discount: j['discount'] as int,
      total: j['total'] as int,
      pointsEarned: j['pointsEarned'] as int,
      address: j['address'] as String,
      // поля ниже могут отсутствовать в старых сохранённых заказах
      contact: j['contact'] as String? ?? '',
      isPickup: j['isPickup'] as bool? ?? false,
      eta: j['eta'] != null
          ? DateTime.parse(j['eta'] as String)
          : date.add(const Duration(days: 3)),
    );
  }
}
