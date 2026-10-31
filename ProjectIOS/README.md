# Footwear

Flutter coursework app inspired by Maison Margiela.
LAB 5, LAB 6 and LAB 7 are implemented in the same project.

Author: Nurdaulet Orazgeldy
Project folder: ProjectIOS

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

### Registration Flow

- First launch opens the registration screen.
- Successful registration saves name, email, role and a registration flag
  locally using shared_preferences.
- A success dialog shows the saved details.
- Continue opens the root screen with the bottom navigation bar.
- Later launches on the same installation open the root screen directly.
- Passwords are not saved or printed.

## LAB 7 — Multi-Screen App with Navigation and Tabs

Topics: Navigator.push, Navigator.pop, passing data arguments,
BottomNavigationBar.

### Root screen (BottomNavigationBar)

- **Feed:** product list filtered by category (TABI, REPLICA, FUTURE).
  Each card shows an image, title and price.
- **Favorites:** shows the products saved with the bookmark button.
  Tapping a card opens its details.
- **Profile:** shows the name, email and role saved at registration,
  a notifications switch, the number of saved items and a button
  to clear favorites.
- Tabs are kept in an IndexedStack, so the scroll position and the selected
  category are preserved when switching tabs.

### Detail screen (Navigator.push with arguments)

- Tapping a product in Feed or Favorites calls Navigator.push.
- The complete Product object (name, description, image, price, category,
  rating, tags) is passed through RouteSettings.arguments and read with
  ModalRoute.of(context)!.settings.arguments.
- The bookmark button on the detail screen is synchronized with the
  Feed and Favorites tabs.

### Back navigation (Navigator.pop)

- AppBar back icon calls Navigator.pop.
- The "Back to list" button in the body also calls Navigator.pop.
- The app is not restarted: the previous tab, category and bookmarks
  stay as they were.

### State management

Favorites are stored in a shared FavoritesModel (ChangeNotifier).
Widgets listen to it with ListenableBuilder.

## Project Structure

    lib/
      main.dart
      data/products.dart
      models/product.dart
      state/favorites_model.dart
      screens/
        root_screen.dart
        feed_tab.dart
        favorites_tab.dart
        profile_tab.dart
        detail_screen.dart
        registration_screen.dart
      widgets/
        product_cover.dart
        product_info.dart
        cart_action_bar.dart

## Run

From the repository root:

    cd ProjectIOS
    flutter pub get
    flutter run

For Xcode, open ProjectIOS/ios/Runner.xcworkspace.

## Checks

Inside ProjectIOS:

    dart format lib test
    flutter analyze
    flutter test

## Limitations

- Registration is local; there is no server account or sign-in.
- The Profile screen only displays saved data; it cannot be edited.
- Bookmarks reset after a full restart.
- Add to Cart only shows a confirmation.
- Prices and ratings are demo data.

## Credits

Product images and design inspiration: https://www.maisonmargiela.com/
Fonts: Cormorant Garamond and Roboto Mono.

Educational project.

## Author

Nurdaulet Orazgeldy