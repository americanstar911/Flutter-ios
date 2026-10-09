import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lab5/main.dart';

void main() {
  const screenSizes = [
    Size(320, 568),
    Size(430, 932),
    Size(1024, 768),
    Size(568, 320),
  ];

  for (final size in screenSizes) {
    testWidgets('No overflow on ${size.width} x ${size.height}', (
      tester,
    ) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = size;

      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(const Lab5App());
      await tester.pumpAndSettle();

      expect(find.text('Nike Sneakers'), findsOneWidget);
      expect(find.text('Add to Cart'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Bookmark and cart work', (tester) async {
    await tester.pumpWidget(const Lab5App());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Bookmark product'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Remove bookmark'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove bookmark'));
    await tester.pumpAndSettle();

    expect(find.byTooltip('Bookmark product'), findsOneWidget);

    await tester.tap(find.text('Add to Cart'));
    await tester.pumpAndSettle();

    expect(find.text('Items in cart: 1'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
