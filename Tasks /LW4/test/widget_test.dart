import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Follow, likes and reset update the profile', (tester) async {
    tester.view.physicalSize = const Size(375, 812);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const BusinessApp());
    expect(find.text('1320'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Follow'));
    await tester.pump();
    expect(find.text('Following'), findsOneWidget);
    expect(find.text('1321'), findsOneWidget);

    await tester.tap(find.text('Following'));
    await tester.pump();
    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('1320'), findsOneWidget);

    await tester.tap(find.text('Like'));
    await tester.pump();
    expect(find.text('121'), findsOneWidget);

    await tester.tap(find.text('Dislike'));
    await tester.pump();
    expect(find.text('120'), findsOneWidget);

    await tester.tap(find.text('Follow'));
    await tester.tap(find.text('Like'));
    await tester.pump();
    await tester.tap(find.text('Reset'));
    await tester.pump();
    expect(find.text('Follow'), findsOneWidget);
    expect(find.text('1320'), findsOneWidget);
    expect(find.text('120'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
