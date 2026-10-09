abstract class MediaItem {
  String id;
  String title;
  double price;
  MediaItem({required this.id, required this.title, required this.price});
  String getDetails();
}