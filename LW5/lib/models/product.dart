class Product {
  final String id;
  final String name;
  final String category;
  final String imagePath;
  final int price;
  final double rating;
  final String description;
  final List<String> tags;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imagePath,
    required this.price,
    required this.rating,
    required this.description,
    required this.tags,
  });

  String get formattedPrice => '\$$price';
}
