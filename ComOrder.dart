void main() {
  processFunction(
    orderId: 123,
    ItemPrice: 10000,
    promoCode: 'SAVE10',
    deliveryFee: null,
  );
  processFunction(
    orderId: 124,
    ItemPrice: 10000,
    promoCode: '',
    deliveryFee: 300.0,
  );
}

void processFunction({
  required int orderId,
  required double ItemPrice,
  String? promoCode,
  double? deliveryFee,
}) {
  if (promoCode == 'SAVE10') {
    ItemPrice = (ItemPrice * 0.9);
  }
  deliveryFee ??= 500.0;
  if (deliveryFee < 500.0) {
    deliveryFee = 500.0;
  }
  double total = ItemPrice + deliveryFee;
  print('orderId: $orderId');
  print('ItemPrice: $ItemPrice');
  print('total: $total\n-------');
}