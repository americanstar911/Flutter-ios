const freeDeliveryFrom = 2000;

String formatDay(DateTime d) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${d.day} ${months[d.month - 1]}';
}

class DeliveryMethod {
  final String name;
  final int price;
  final int minDays;
  final int maxDays;
  final bool isPickup;
  final bool freeOverThreshold;

  const DeliveryMethod({
    required this.name,
    required this.price,
    required this.minDays,
    required this.maxDays,
    this.isPickup = false,
    this.freeOverThreshold = false,
  });

  int priceFor(int subtotal) =>
      freeOverThreshold && subtotal >= freeDeliveryFrom ? 0 : price;

  String etaLabel() {
    final now = DateTime.now();
    final first = now.add(Duration(days: minDays));
    final last = now.add(Duration(days: maxDays));
    if (isPickup) return 'Ready ${formatDay(first)}';
    if (minDays == maxDays) return 'Arrives ${formatDay(last)}';
    return 'Arrives ${formatDay(first)} - ${formatDay(last)}';
  }
}

const deliveryMethods = [
  DeliveryMethod(
    name: 'Courier',
    price: 15,
    minDays: 2,
    maxDays: 3,
    freeOverThreshold: true,
  ),
  DeliveryMethod(name: 'Express', price: 30, minDays: 1, maxDays: 1),
  DeliveryMethod(
    name: 'Pickup from store',
    price: 0,
    minDays: 1,
    maxDays: 2,
    isPickup: true,
  ),
];

const pickupPoints = [
  'Flagship store',
  'City Mall boutique',
  'Airport boutique',
];
