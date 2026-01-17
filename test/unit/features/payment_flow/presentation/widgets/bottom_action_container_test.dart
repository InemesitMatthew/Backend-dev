import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BottomActionContainer', () {
    testWidgets('should render child widget correctly', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Button');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomActionContainer(
              child: testChild,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.text('Test Button'), findsOneWidget);
      expect(find.byType(BottomActionContainer), findsOneWidget);
    });

    testWidgets('should apply correct styling and decoration', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomActionContainer(
              child: testChild,
            ),
          ),
        ),
      );
      
      // Assert
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(BottomActionContainer),
          matching: find.byType(Container),
        ),
      );
      
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, equals(Palette.surface));
      expect(decoration.border, isA<Border>());
      
      final border = decoration.border as Border;
      expect(border.top.color, equals(Palette.border2.withValues(alpha: 0.2)));
      expect(border.top.width, equals(0.75));
    });

    testWidgets('should use default padding when none provided', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) => Scaffold(
              body: BottomActionContainer(
                child: testChild,
              ),
            ),
          ),
        ),
      );
      
      // Assert
      final paddingFinder = find.descendant(
        of: find.byType(BottomActionContainer),
        matching: find.byType(Padding),
      );
      final paddings = tester
          .widgetList<Padding>(paddingFinder)
          .where(
            (padding) =>
                padding.padding ==
                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          )
          .toList();
      
      // Default padding should be symmetric(horizontal: 16, vertical: 10)
      expect(paddings, hasLength(1));
    });

    testWidgets('should use custom padding when provided', (WidgetTester tester) async {
      // Arrange
      const testChild = Text('Test Content');
      const customPadding = EdgeInsets.all(20);
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: BottomActionContainer(
              padding: customPadding,
              child: testChild,
            ),
          ),
        ),
      );
      
      // Assert
      final paddingFinder = find.descendant(
        of: find.byType(BottomActionContainer),
        matching: find.byType(Padding),
      );
      final paddings = tester
          .widgetList<Padding>(paddingFinder)
          .where((padding) => padding.padding == customPadding)
          .toList();
      
      expect(paddings, hasLength(1));
    });
  });
}