import 'mediaItem.dart';
import 'downloadable.dart';

class EBook extends MediaItem with Downloadable {
  double fileSizeMB;
  String author;
  EBook({
    required super.id,
    required super.title,
    required super.price,
    required this.fileSizeMB,
    required this.author,
  });
  @override
  String getDetails() {
    return "EBook: $title by $author, size: ${fileSizeMB}MB, price: \$$price";
  }
}