const menu = {'Adobo rice': 85.0, 'Iced tea': 35.0, 'Turon': 25.0};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  const OrderItem({
    required this.name,
    required this.price,
    required this.qty,
  });

  double get subtotal => price * qty;
}

OrderItem orderOf(String name, int qty) {
  final price = menu[name];
  if (price == null) {
    throw ArgumentError('Item "$name" is not on the menu.');
  }
  return OrderItem(name: name, price: price, qty: qty);
}

double total(List<OrderItem> items) {
  return items.fold(0.0, (sum, item) => sum + item.subtotal);
}

void printReceipt(List<OrderItem> items, {String? customer}) {
  final customerName = customer ?? 'Guest';
  print('Order for $customerName');

  for (final item in items) {
    final itemDesc = '${item.qty} x ${item.name}';
    final itemSub = item.subtotal.toStringAsFixed(2);
    print('${itemDesc.padRight(18)}${itemSub.padLeft(10)}');
  }

  final subtotalVal = total(items);
  print('Subtotal'.padRight(18) + subtotalVal.toStringAsFixed(2).padLeft(10));

  double finalTotal = subtotalVal;
  if (subtotalVal >= 300) {
    final discount = subtotalVal * 0.10;
    print('Discount 10%'.padRight(18) + '-${discount.toStringAsFixed(2)}'.padLeft(10));
    finalTotal -= discount;
  }

  print('Total'.padRight(18) + finalTotal.toStringAsFixed(2).padLeft(10));
}

void main() {
  // First receipt: 3 Adobo rice, 1 Iced tea, 3 Turon (Guest)
  final order1 = [
    orderOf('Adobo rice', 3),
    orderOf('Iced tea', 1),
    orderOf('Turon', 3),
  ];
  printReceipt(order1);

  print('\n-----------------------------\n');

  // Second receipt: Below 300, named customer
  final order2 = [
    orderOf('Adobo rice', 1),
    orderOf('Iced tea', 2),
  ];
  printReceipt(order2, customer: 'Maria');
}