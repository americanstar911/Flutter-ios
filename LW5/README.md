# LAB 5 — Adaptive Product Detail Screen

A Flutter product detail screen for a sneaker store.

## Features

- Product photo with a bookmark button over it.
- Product title, star rating and price.
- Category badges that wrap onto the next line.
- A sticky bottom action bar.
- A full-width Add to Cart button.
- Working bookmark toggle and cart counter.
- A confirmation message after adding a product.

## Layout

- Stack and Positioned place the bookmark over the photo.
- Row arranges the title and rating.
- Wrap arranges category badges.
- Expanded makes the cart button fill the available width.
- ListView allows scrolling.
- SafeArea keeps content away from system areas.
- ConstrainedBox limits the content width on large screens.

## Folder Structure

- lib/main.dart — application entry point.
- lib/screens/product_screen.dart — screen and interactive state.
- lib/widgets/product_cover.dart — photo and bookmark.
- lib/widgets/product_info.dart — product information.
- lib/widgets/cart_action_bar.dart — bottom action bar.
- assets/images/sneaker.jpg — local product photo.
- test/widget_test.dart — layout and interaction tests.

## Run

From the repository root:

```bash
cd LW5
flutter pub get
flutter run
```

Select iPhone 17 to run on the iOS simulator.

## Validation

From the LW5 folder:

```bash
flutter analyze
flutter test
```

All 5 tests passed. Layout tests cover 320×568, 430×932,
1024×768 and 568×320. Interaction tests check the bookmark
toggle and cart counter.

## Notes

Product data is for demonstration.
Bookmark and cart state are stored in memory.

Photo source: [Unsplash](https://images.unsplash.com/photo-1542291026-7eec264c27ff).

## Author

Nurdaulet Orazgeldy