import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blood_system/theme/theme.dart';
import 'package:blood_system/widgets/red_header.dart';

void main() {
  group('RedHeader Widget Tests', () {
    // Test 1: Verify title is displayed
    testWidgets('RedHeader displays the correct title', (WidgetTester tester) async {
      // Arrange
      const title = 'Blood Donation';
      await tester.pumpWidget(
        const MaterialApp(
          home: RedHeader(title: title),
        ),
      );

      // Act
      final titleFinder = find.text(title);

      // Assert
      expect(titleFinder, findsOneWidget);
      expect(
        tester.widget<Text>(titleFinder).style?.fontSize,
        28, // Default font size for non-small screens
      );
    });

    // Test 2: Verify background image and red overlay are rendered
    testWidgets('RedHeader renders background image and red overlay', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: RedHeader(title: 'Test Header'),
        ),
      );

      // Act
      final imageFinder = find.byType(Image);
      final containerFinder = find.byWidgetPredicate(
            (widget) =>
        widget is Container &&
            widget.decoration is BoxDecoration &&
            (widget.decoration as BoxDecoration).color == AppColors.red.withOpacity(0.7),
      );

      // Assert
      expect(imageFinder, findsOneWidget);
      expect(containerFinder, findsOneWidget);
    });

    // Test 3: Verify menu button appears and triggers callback
    testWidgets('RedHeader shows menu button and triggers onMenuPressed', (WidgetTester tester) async {
      // Arrange
      bool menuPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: RedHeader(
            title: 'Test Header',
            onMenuPressed: () {
              menuPressed = true;
            },
          ),
        ),
      );

      // Act
      final menuButtonFinder = find.byIcon(Icons.menu);
      await tester.tap(menuButtonFinder);
      await tester.pump();

      // Assert
      expect(menuButtonFinder, findsOneWidget);
      expect(menuPressed, isTrue);
    });

    // Test 4: Verify back button appears and triggers onBack
    testWidgets('RedHeader shows back button and triggers onBack when showBack is true', (WidgetTester tester) async {
      // Arrange
      bool backPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: RedHeader(
            title: 'Test Header',
            showBack: true,
            onBack: () {
              backPressed = true;
            },
          ),
        ),
      );

      // Act
      final backButtonFinder = find.byIcon(Icons.arrow_back);
      await tester.tap(backButtonFinder);
      await tester.pump();

      // Assert
      expect(backButtonFinder, findsOneWidget);
      expect(backPressed, isTrue);
    });

    // Test 5: Verify settings button appears when showSettings is true
    testWidgets('RedHeader shows settings button when showSettings is true', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: RedHeader(
            title: 'Test Header',
            showSettings: true,
          ),
        ),
      );

      // Act
      final settingsButtonFinder = find.byIcon(Icons.settings_outlined);

      // Assert
      expect(settingsButtonFinder, findsOneWidget);
    });

    // Test 6: Verify notification button appears and triggers onNotificationPressed
    testWidgets('RedHeader shows notification button and triggers onNotificationPressed', (WidgetTester tester) async {
      // Arrange
      bool notificationPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: RedHeader(
            title: 'Test Header',
            onNotificationPressed: () {
              notificationPressed = true;
            },
          ),
        ),
      );

      // Act
      final notificationButtonFinder = find.byIcon(Icons.notifications);
      await tester.tap(notificationButtonFinder);
      await tester.pump();

      // Assert
      expect(notificationButtonFinder, findsOneWidget);
      expect(notificationPressed, isTrue);
    });

    // Test 7: Verify layout adjusts for small screens
    testWidgets('RedHeader adjusts title font size for small screens', (WidgetTester tester) async {
      // Arrange: Simulate a small screen (width < 400)
      tester.view.physicalSize = const Size(380 * 2, 800 * 2); // physicalSize = logicalSize * devicePixelRatio
      tester.view.devicePixelRatio = 2.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: RedHeader(title: 'Test Header'),
        ),
      );

      // Act
      final titleFinder = find.text('Test Header');

      // Assert
      expect(tester.widget<Text>(titleFinder).style?.fontSize, 24); // Small screen font size

      // Reset view for other tests
      tester.view.reset();
    });


  });
}