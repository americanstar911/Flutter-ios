import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCover extends StatelessWidget {
  final String imagePath;
  final bool isBookmarked;
  final VoidCallback onBookmarkPressed;

  const ProductCover({
    super.key,
    this.imagePath = 'assets/images/tabi_1.webp',
    required this.isBookmarked,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              tooltip: isBookmarked ? 'Remove bookmark' : 'Bookmark product',
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              onPressed: onBookmarkPressed,
              icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isBookmarked;
  final VoidCallback onTap;
  final VoidCallback onBookmarkPressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.isBookmarked,
    required this.onTap,
    required this.onBookmarkPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductCover(
              imagePath: product.imagePath,
              isBookmarked: isBookmarked,
              onBookmarkPressed: onBookmarkPressed,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.formattedPrice,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      const Icon(Icons.arrow_forward, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
