import 'mediaItem.dart';
import 'downloadable.dart';

class Audiobook extends MediaItem with Downloadable {
  double durationHours;
  String narrator;

  Audiobook({
    required super.id,
    required super.title,
    required super.price,
    required this.durationHours,
    required this.narrator,
  });
  @override
  String getDetails() {
    return "Audiobook: $title, narrated by $narrator, duration: ${durationHours}h, price: \$$price";
  }
}