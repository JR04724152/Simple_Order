const menu = {
  'Adobo rice': 85.0,
  'Iced tea': 35.0,
  'Turon': 25.0,
};

class OrderItem {
  final String name;
  final double price;
  final int qty;

  OrderItem(this.name, this.price, this.qty);

  double get subtotal => price * qty;
}

double total(List<OrderItem> items) =>
    items.fold(0.0, (sum, item) => sum + item.subtotal);

void printReceipt(List<OrderItem> items, {String? customer}) {
  customer ??= 'Guest';

  double subtotal = total(items);
  double discount = subtotal >= 300 ? subtotal * 0.10 : 0.0;
  double finalTotal = subtotal - discount;

  print('Order for $customer');

  for (var item in items) {
    print(
      '${item.qty} x ${item.name}\t${item.subtotal.toStringAsFixed(2)}',
    );
  }

  print('Subtotal\t${subtotal.toStringAsFixed(2)}');

  if (discount > 0) {
    print('Discount 10%\t-${discount.toStringAsFixed(2)}');
  }

  print('Total\t${finalTotal.toStringAsFixed(2)}');
}

void main() {
  final order = [
    OrderItem('Adobo rice', menu['Adobo rice']!, 3),
    OrderItem('Iced tea', menu['Iced tea']!, 1),
    OrderItem('Turon', menu['Turon']!, 3),
  ];

  printReceipt(order);
}