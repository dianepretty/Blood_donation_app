import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:blood_system/theme/theme.dart'; // Adjust import path based on your project structure
import 'package:blood_system/widgets/select-role.dart'; // Adjust import path

void main() {
  group('RoleSelectionDialog Widget Tests', () {
    // Test 1: Verify dialog renders with title and dropdown options
    testWidgets('Renders dialog with title and dropdown options', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.red, // Ensure theme is set to avoid null AppColors.red
          ),
          home: const RoleSelectionDialog(),
        ),
      );

      // Act: Open the dropdown to make items visible
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle(); // Wait for dropdown to open

      // Assert
      expect(find.text('Select Your Role'), findsOneWidget);
      expect(find.text('Hospital admin'), findsOneWidget);
      expect(find.text('Volunteer'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
    });

    // Test 2: Verify dropdown updates selectedRole when a role is selected
    testWidgets('Dropdown updates selectedRole when a role is selected', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(primarySwatch: Colors.red),
          home: const RoleSelectionDialog(),
        ),
      );

      // Act: Open the dropdown and select "Volunteer"
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle(); // Wait for dropdown to open
      // Use a more precise finder for the dropdown item
      final volunteerItemFinder = find.byWidgetPredicate(
            (widget) => widget is DropdownMenuItem<String> && widget.value == 'Volunteer',
      );
      await tester.tap(volunteerItemFinder.last);
      await tester.pumpAndSettle(); // Wait for dropdown to close and state to update

      // Debug: Print widget tree to inspect what's rendered
      debugPrint('Widget tree after selecting Volunteer:');
      debugPrint(tester.allWidgets.map((w) => w.toString()).join('\n'));

      // Assert: Verify the dropdown displays "Volunteer" as the selected value
      final selectedVolunteerFinder = find.text('Volunteer');
      expect(selectedVolunteerFinder, findsOneWidget); // Expect only the selected value
    });

    // Test 3: Verify Continue button is disabled when no role is selected
    testWidgets('Continue button is disabled when no role is selected', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: RoleSelectionDialog(),
        ),
      );

      // Act
      final buttonFinder = find.byType(ElevatedButton);
      final elevatedButton = tester.widget<ElevatedButton>(buttonFinder);

      // Assert
      expect(elevatedButton.onPressed, isNull); // Button is disabled
      expect(elevatedButton.style?.backgroundColor?.resolve({})?.value, Colors.grey.value);
    });

    // Test 4: Verify Continue button is enabled and styled when a role is selected
    testWidgets('Continue button is enabled and styled when a role is selected', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: RoleSelectionDialog(),
        ),
      );

      // Act: Select "Hospital admin" from the dropdown
      await tester.tap(find.byType(DropdownButtonFormField<String>));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Hospital admin').last);
      await tester.pumpAndSettle();

      // Assert
      final buttonFinder = find.byType(ElevatedButton);
      final elevatedButton = tester.widget<ElevatedButton>(buttonFinder);
      expect(elevatedButton.onPressed, isNotNull); // Button is enabled
      expect(elevatedButton.style?.backgroundColor?.resolve({})?.value, AppColors.red.value);
    });

    // Test 5: Verify dialog styling (background color)
    testWidgets('Dialog has correct background color', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: RoleSelectionDialog(),
        ),
      );

      // Act
      final dialogFinder = find.byType(AlertDialog);
      final alertDialog = tester.widget<AlertDialog>(dialogFinder);

      // Assert
      expect(alertDialog.backgroundColor, Colors.white);
    });
  });
}

// Mock NavigatorObserver to track navigation
class MockNavigatorObserver extends NavigatorObserver {
  List<Route> pushedRoutes = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    pushedRoutes.add(route);
  }
}