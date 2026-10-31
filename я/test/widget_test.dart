import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab5/main.dart';
import 'package:lab5/screens/product_screen.dart';
import 'package:lab5/widgets/product_cover.dart';

Future<void> launchApp(WidgetTester tester, Size size) async {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;

  addTearDown(() {
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  await tester.pumpWidget(const Lab5App(isRegistered: true));
  await tester.pumpAndSettle();
}

Future<void> openFirstProduct(WidgetTester tester) async {
  final card = find.byType(ProductCard).first;

  await tester.ensureVisible(card);
  await tester.pumpAndSettle();

  await tester.tapAt(tester.getTopLeft(card) + const Offset(24, 80));
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    final headingFont = FontLoader('CormorantGaramond')
      ..addFont(rootBundle.load('assets/fonts/CormorantGaramond.ttf'));

    final bodyFont = FontLoader('RobotoMono')
      ..addFont(rootBundle.load('assets/fonts/RobotoMono.ttf'));

    await headingFont.load();
    await bodyFont.load();
  });

  const sizes = [
    Size(320, 568),
    Size(430, 932),
    Size(1024, 768),
    Size(568, 320),
  ];

  for (final size in sizes) {
    testWidgets('Catalog and details fit ${size.width} x ${size.height}', (
      tester,
    ) async {
      await launchApp(tester, size);

      expect(find.byType(CatalogScreen), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(3));
      expect(tester.takeException(), isNull);

      await openFirstProduct(tester);

      expect(find.byType(ProductScreen), findsOneWidget);
      expect(find.text('Tabi Babouches'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      expect(tester.takeException(), isNull);

      final buttonPosition = tester.getRect(find.text('Add to Cart'));

      await tester.ensureVisible(find.text('ABOUT THIS PRODUCT'));
      await tester.pumpAndSettle();

      expect(tester.getRect(find.text('Add to Cart')), buttonPosition);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Categories, navigation, bookmarks and button work', (
    tester,
  ) async {
    await launchApp(tester, const Size(430, 932));

    const categoryProducts = {
      'TABI': 'TABI BABOUCHES',
      'REPLICA': 'REPLICA SNEAKERS SUEDE',
      'FUTURE': 'FUTURE SNEAKER BLACK',
    };

    for (final entry in categoryProducts.entries) {
      await tester.tap(find.widgetWithText(ChoiceChip, entry.key));
      await tester.pumpAndSettle();

      expect(find.byType(ProductCard), findsNWidgets(3));
      expect(find.text(entry.value), findsOneWidget);
      expect(tester.takeException(), isNull);
    }

    await tester.tap(find.widgetWithText(ChoiceChip, 'REPLICA'));
    await tester.pumpAndSettle();

    await openFirstProduct(tester);

    expect(find.text('Replica Sneakers Suede'), findsOneWidget);

    await tester.tap(find.byTooltip('Bookmark product'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Remove bookmark'), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();

    expect(find.text('You selected Replica Sneakers Suede'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Show bookmarked products'));
    await tester.pumpAndSettle();

    expect(find.byType(ProductCard), findsOneWidget);
    expect(find.text('REPLICA SNEAKERS SUEDE'), findsOneWidget);

    final bookmark = find.byTooltip('Remove bookmark');

    await tester.ensureVisible(bookmark);
    await tester.pumpAndSettle();
    await tester.tap(bookmark);
    await tester.pumpAndSettle();

    expect(find.byType(ProductCard), findsNothing);
    expect(
      find.text('No bookmarked products in this section.'),
      findsOneWidget,
    );
    expect(tester.takeException(), isNull);
  });
}
