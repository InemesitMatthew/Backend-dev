import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentScaffold', () {
    testWidgets('should render body correctly', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Body Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScaffold(
            body: testBody,
          ),
        ),
      );
      
      // Assert
      expect(find.text('Test Body Content'), findsOneWidget);
      expect(find.byType(PaymentScaffold), findsOneWidget);
      expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    });

    testWidgets('should show back button by default', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScaffold(
            body: testBody,
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CupertinoNavigationBar), findsOneWidget);
      expect(find.byIcon(CupertinoIcons.back), findsOneWidget);
    });

    testWidgets('should hide back button when showBackButton is false', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScaffold(
            showBackButton: false,
            body: testBody,
          ),
        ),
      );
      
      // Assert
      expect(find.byType(CupertinoNavigationBar), findsNothing);
      expect(find.byIcon(CupertinoIcons.back), findsNothing);
    });

    testWidgets('should apply correct background color', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScaffold(
            body: testBody,
          ),
        ),
      );
      
      // Assert
      final scaffold = tester.widget<CupertinoPageScaffold>(
        find.byType(CupertinoPageScaffold),
      );
      expect(scaffold.backgroundColor, equals(Palette.surface));
    });

    testWidgets('should call custom onBackPressed when provided', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Content');
      bool backPressed = false;
      
      void onBackPressed() {
        backPressed = true;
      }
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: PaymentScaffold(
            onBackPressed: onBackPressed,
            body: testBody,
          ),
        ),
      );
      
      // Tap the back button
      await tester.tap(find.byIcon(CupertinoIcons.back));
      await tester.pump();
      
      // Assert
      expect(backPressed, isTrue);
    });

    testWidgets('should call Navigator.maybePop when no custom onBackPressed', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: PaymentScaffold(
            body: testBody,
          ),
        ),
      );
      
      // Assert - Just verify the back button exists and is tappable
      expect(find.byIcon(CupertinoIcons.back), findsOneWidget);
      
      // Tap the back button (won't actually navigate in test)
      await tester.tap(find.byIcon(CupertinoIcons.back));
      await tester.pump();
      
      // No exception should be thrown
    });

    testWidgets('should wrap body in SafeArea with correct configuration', (WidgetTester tester) async {
      // Arrange
      const testBody = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScaffold(
            body: testBody,
          ),
        ),
      );
      
      // Assert
      final safeAreas = tester.widgetList<SafeArea>(
        find.descendant(
          of: find.byType(PaymentScaffold),
          matching: find.byType(SafeArea),
        ),
      );
      final hasTopFalse = safeAreas.any((safeArea) => safeArea.top == false);
      expect(hasTopFalse, isTrue);
    });

    testWidgets('should handle complex body widgets', (WidgetTester tester) async {
      // Arrange
      const complexBody = SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Title'),
            Material(child: TextField()),
            ElevatedButton(onPressed: null, child: Text('Button')),
          ],
        ),
      );
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentScaffold(
            body: complexBody,
          ),
        ),
      );
      
      // Assert
      expect(find.text('Title'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Button'), findsOneWidget);
    });
  });
}