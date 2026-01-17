import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentScreenHeader', () {
    testWidgets('should render title correctly', (WidgetTester tester) async {
      // Arrange
      const title = 'Payment Method';
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PaymentScreenHeader(
              title: title,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.text(title), findsOneWidget);
      expect(find.byType(PaymentScreenHeader), findsOneWidget);
    });

    testWidgets('should render title and subtitle when both provided', (WidgetTester tester) async {
      // Arrange
      const title = 'Enter Card Details';
      const subtitle = 'Your card information is securely encrypted.';
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PaymentScreenHeader(
              title: title,
              subtitle: subtitle,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.text(title), findsOneWidget);
      expect(find.text(subtitle), findsOneWidget);
    });

    testWidgets('should not render subtitle when not provided', (WidgetTester tester) async {
      // Arrange
      const title = 'Payment Method';
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PaymentScreenHeader(
              title: title,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.text(title), findsOneWidget);
      // Should only find one TextWidget (the title)
      expect(find.byType(TextWidget), findsOneWidget);
    });

    testWidgets('should apply correct typography styles', (WidgetTester tester) async {
      // Arrange
      const title = 'Test Title';
      const subtitle = 'Test Subtitle';
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PaymentScreenHeader(
              title: title,
              subtitle: subtitle,
            ),
          ),
        ),
      );
      
      // Assert
      final titleWidgets = tester.widgetList<TextWidget>(find.byType(TextWidget));
      final titleWidget = titleWidgets.first;
      final subtitleWidget = titleWidgets.last;
      
      // Title styling
      expect(titleWidget.fontSize, equals(32));
      expect(titleWidget.fontWeight, equals(FontWeight.w500));
      expect(titleWidget.textColor, equals(Palette.black));
      expect(titleWidget.fontFamily, equals(AppFontFamily.redwing));
      
      // Subtitle styling
      expect(subtitleWidget.fontSize, equals(14));
      expect(subtitleWidget.fontWeight, equals(FontWeight.w400));
      expect(subtitleWidget.textColor, equals(Palette.black.withValues(alpha: 0.6)));
    });

    testWidgets('should have correct layout structure', (WidgetTester tester) async {
      // Arrange
      const title = 'Test Title';
      const subtitle = 'Test Subtitle';
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: PaymentScreenHeader(
              title: title,
              subtitle: subtitle,
            ),
          ),
        ),
      );
      
      // Assert
      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(PaymentScreenHeader),
          matching: find.byType(Column),
        ),
      );
      
      expect(column.crossAxisAlignment, equals(CrossAxisAlignment.start));
    });
  });
}