# Footwear

Flutter coursework app inspired by Maison Margiela.
LAB 5 and LAB 6 are implemented in the same project.

Author: Nurdaulet Orazgeldy
Project folder: LW5

## LAB 5 — Catalog and Product Details

- Three categories: TABI, REPLICA and FUTURE.
- Nine products with local images.
- Product details: name, price, rating, description and tags.
- Bookmark buttons and a favourites filter.
- Add to Cart button with a confirmation message.
- Responsive layout and scrollable screens.

Widgets: Column, Row, Card, Stack, Positioned, Wrap,
Expanded, LayoutBuilder and SafeArea.

## LAB 6 — Registration and Form Validation

- Full Name: required and cannot be empty.
- Email: required and validated with @ and a domain dot.
- Password: required, minimum 6 characters and hidden.
- Confirm Password: must match the password exactly.
- Required Terms and Conditions checkbox.
- Role dropdown: Student, Teacher or Developer.
- GlobalKey<FormState> validates the form on submission.
- Validation also updates while typing.
- Invalid fields show error messages.
- Valid submissions print name, email, role and terms acceptance.
- TextEditingController instances are released in dispose().

## Registration Flow

- First launch opens the registration screen.
- Successful registration saves name, email, role and a registration flag
  locally using shared_preferences.
- A success dialog shows the saved details.
- Continue opens the catalog.
- Later launches on the same installation open the catalog directly.
- Passwords are not saved or printed.

The catalog profile icon opens the form again as a demonstration.
That form shows a success SnackBar and does not update the saved profile.

## Run

From the repository root:

    cd LW5
    flutter pub get
    flutter run

For Xcode, open LW5/ios/Runner.xcworkspace.

## Checks

Inside LW5:

    dart format lib test
    flutter analyze
    flutter test

## Limitations

- Registration is local; there is no server account or sign-in.
- There is no separate profile viewing or editing screen.
- Bookmarks reset after a full restart.
- Add to Cart only shows a confirmation.
- Prices and ratings are demo data.

## Credits

Product images and design inspiration: https://www.maisonmargiela.com/
Fonts: Cormorant Garamond and Roboto Mono.

Educational project.

## Author

Nurdaulet Orazgeldyы