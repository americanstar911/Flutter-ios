import 'audiobook.dart';
import 'ebook.dart';
import 'shoppingCart.dart';

void main() {
  var cart = ShoppingCart();
  cart.addItem(
    Audiobook(
      id: "A1",
      title: "The Hobbit",
      price: 9.99,
      durationHours: 11.5,
      narrator: "Rob Inglis",
    ),
  );
  cart.addItem(
    EBook(
      id: "E1",
      title: "Clean Architecture",
      price: 14.99,
      fileSizeMB: 5.2,
      author: "Robert Martin",
    ),
  );
  cart.printReceipt();

  print("\nItems under \$10:");
  for (var item in cart.filterByMaxPrice(10.0)) {
    print("- ${item.title}");
  }
}