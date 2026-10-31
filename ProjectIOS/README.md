# Footwear

Flutter coursework app inspired by Maison Margiela.
LAB 5, LAB 6, LAB 7 and LW8 are implemented in the same project.

Author: Nurdaulet Orazgeldy
Project folder: ProjectIOS

## LAB 5 — Catalog and Product Details

- Three categories: TABI, REPLICA and FUTURE.
- Nine products with local images.
- Product details: name, price, rating, description and tags.
- Bookmark buttons for favourites.
- Responsive layout and scrollable screens.

## LAB 6 — Registration and Form Validation

- Full Name, Email, Password, Confirm Password, Terms checkbox and Role.
- GlobalKey<FormState> validation on submit and while typing.
- Successful registration saves name, email and role with shared_preferences.
- First launch opens registration, later launches open the app directly.
- Passwords are not saved or printed.

## LAB 7 — Multi-Screen App with Navigation and Tabs

- Root screen with BottomNavigationBar: Feed, Favorites and Profile.
- Tabs are kept in an IndexedStack, so state is preserved when switching.
- Tapping a product calls Navigator.push and passes the whole Product object
  through RouteSettings.arguments.
- Detail screen has an AppBar back icon and a "Back to list" button, both
  calling Navigator.pop.
- Favorites are stored in a shared ChangeNotifier and synchronized between
  Feed, Favorites and the detail screen.

## Extra Features

- **Size selection:** sizes 36-44; Add to Cart is disabled until a size is
  selected.
- **Shopping cart:** AppBar icon with a badge, quantity controls, removal,
  subtotal and a progress bar to free courier delivery.
- **Delivery:** courier, express and pickup with estimated dates. Courier is
  free for orders over $2000. Address, pickup point and contact validation;
  saved details are reused next time.
- **Order tracking:** timeline from "Order placed" to "Delivered". In demo
  mode the status changes every 15 seconds.
- **Loyalty program:** 5% of each order is returned as points, 1 point = $1
  discount, levels Bronze / Silver / Gold with a progress bar in Profile.
- **Order history:** orders and points are saved locally and shown in Profile.
- **Notifications setting:** the switch in Profile enables or disables
  pop-up messages (added to cart, order status). The choice is saved.

## LW8 — Dynamic Lists, Grids and Scrollable Touch Interactions

Screen: Smart Catalog (grid icon in the AppBar of the root screen).

- **Dual view:** ListView.separated (avatar, title, category tag, rating,
  price, thin dividers) and a 2-column GridView.builder with
  childAspectRatio 0.72. An AppBar button toggles between them.
- **Pull-to-Refresh:** RefreshIndicator simulates a 1.5 second request with
  Future.delayed and inserts a new item at index 0 using setState.
- **Swipe-to-Delete:** every item is wrapped in Dismissible with
  ValueKey(product.id). Swiping right-to-left shows a red background with
  Icons.delete.
- **Undo:** a floating SnackBar with an UNDO action puts the item back at its
  original index.
- **Empty state:** when all items are removed, the screen shows an icon,
  "Catalog is Empty" and a "Reset Catalog" button that restores the seed data.

In Chrome the mouse is enabled as a drag device so pull-to-refresh works
without a touch screen.

## Project Structure

    lib/
      main.dart
      data/products.dart
      models/
        product.dart
        cart_item.dart
        order.dart
        delivery.dart
      state/
        favorites_model.dart
        cart_model.dart
        orders_model.dart
        app_settings.dart
      screens/
        registration_screen.dart
        root_screen.dart
        feed_tab.dart
        favorites_tab.dart
        profile_tab.dart
        detail_screen.dart
        cart_screen.dart
        checkout_screen.dart
        order_success_screen.dart
        orders_screen.dart
        tracking_screen.dart
        smart_catalog_screen.dart
        product_screen.dart
      widgets/
        product_cover.dart
        product_info.dart
        product_grid.dart
        cart_action_bar.dart

## Run

From the repository root:

    cd ProjectIOS
    flutter pub get
    flutter run -d chrome

For Xcode, open ProjectIOS/ios/Runner.xcworkspace.

## Checks

Inside ProjectIOS:

    dart format lib
    flutter analyze

## Limitations

- Registration is local; there is no server account or sign-in.
- The Profile screen only displays saved data; it cannot be edited.
- Favorites reset after a full restart.
- Order tracking is a demo timer, not a real delivery service.
- Changes in Smart Catalog are not saved; Reset Catalog restores the seed data.
- product_screen.dart is the original LAB 5 screen and is no longer used.
- Prices and ratings are demo data.

## Credits

Product images and design inspiration: https://www.maisonmargiela.com/
Fonts: Cormorant Garamond and Roboto Mono.

Educational project.