class Book {
  String title;
  String author;
  double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });
}

class Library {
  List<Book> books = [];
  void addBook(Book book) {
    books.add(book);
  }

  List<Book> getAvailableBooks() {
    return books.where((book) => book.isBorrowed == false).toList();
  }

  double getTotalValue() {
    return books.fold(0.0, (sum, book) => sum + book.price);
  }
}

void main() {
  var library = Library();

  library.addBook(
    Book(title: "The Hobbit", author: "J.R.R. Tolkien", price: 20.0),
  );

  library.addBook(
    Book(title: "Harry Potter", author: "J.K. Rowling", price: 18.5, isBorrowed: true,),
  );

  library.addBook(
    Book(title: "The Little Prince", author: "Antoine de Saint-Exupery", price: 10.0),
  );

  print("Available books:");
  for (var books in library.getAvailableBooks()) {
    print("${books.title} by ${books.author} (${books.price})");
  }
  print("\nTotal collection value: ${library.getTotalValue()}");
}