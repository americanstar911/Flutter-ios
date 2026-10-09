import 'package:flutter/material.dart';

class ProductCover extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;

  const ProductCover({
    super.key,
    required this.isBookmarked,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/sneaker.jpg', fit: BoxFit.cover),
            Positioned(
              top: 12,
              right: 12,
              child: IconButton(
                tooltip: isBookmarked ? 'Remove bookmark' : 'Bookmark product',
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.indigo,
                ),
                onPressed: onBookmarkPressed,
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
