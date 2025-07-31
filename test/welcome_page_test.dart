import 'package:blood_system/screens/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Welcomepage Widget Tests', () {
    testWidgets('Welcomepage displays bloodtype icon and background image', (WidgetTester tester) async {

      TestWidgetsFlutterBinding.ensureInitialized();
      await tester.pumpWidget(
        MaterialApp(
          home: Welcomepage(),
        ),
      );

      // Verify that the bloodtype icon is present.
      expect(find.byIcon(Icons.bloodtype), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);

      final containerFinder = find.byWidgetPredicate(
            (widget) => widget is Container && widget.color == Color(0x90D7263D),
      );
      expect(containerFinder, findsOneWidget);

    });
  });
}
