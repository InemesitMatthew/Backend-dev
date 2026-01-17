import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentMethodScreen', () {
    testWidgets('should render screen with correct header', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(PaymentMethodScreen), findsOneWidget);
      expect(find.byType(PaymentScaffold), findsOneWidget);
      expect(find.byType(PaymentScreenHeader), findsOneWidget);
      expect(find.text('Payment Method'), findsOneWidget);
      expect(find.text('Please select your payment method.'), findsOneWidget);
    });

    testWidgets('should render payment method options', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(PaymentMethodTile), findsNWidgets(2));
      expect(find.text(PaymentMethod.card.label), findsOneWidget);
      expect(find.text(PaymentMethod.interac.label), findsOneWidget);
    });

    testWidgets('should render continue button in bottom action container', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(BottomActionContainer), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('should disable continue button when no method selected', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Assert
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.isDisabled, isTrue);
    });

    testWidgets('should enable continue button when method is selected', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Tap on card payment method
      await tester.tap(find.text(PaymentMethod.card.label));
      await tester.pump();
      
      // Assert
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.isDisabled, isFalse);
    });

    testWidgets('should update selection when payment method is tapped', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Initially no method should be selected
      final initialTiles = tester.widgetList<PaymentMethodTile>(find.byType(PaymentMethodTile));
      expect(initialTiles.every((tile) => !tile.isSelected), isTrue);
      
      // Tap on card payment method
      await tester.tap(find.text(PaymentMethod.card.label));
      await tester.pump();
      
      // Assert card method is selected
      final updatedTiles = tester.widgetList<PaymentMethodTile>(find.byType(PaymentMethodTile));
      final cardTile = updatedTiles.firstWhere((tile) => tile.label == PaymentMethod.card.label);
      final interacTile = updatedTiles.firstWhere((tile) => tile.label == PaymentMethod.interac.label);
      
      expect(cardTile.isSelected, isTrue);
      expect(interacTile.isSelected, isFalse);
    });

    testWidgets('should switch selection when different method is tapped', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Tap on card payment method first
      await tester.tap(find.text(PaymentMethod.card.label));
      await tester.pump();
      
      // Then tap on interac payment method
      await tester.tap(find.text(PaymentMethod.interac.label));
      await tester.pump();
      
      // Assert interac method is now selected
      final tiles = tester.widgetList<PaymentMethodTile>(find.byType(PaymentMethodTile));
      final cardTile = tiles.firstWhere((tile) => tile.label == PaymentMethod.card.label);
      final interacTile = tiles.firstWhere((tile) => tile.label == PaymentMethod.interac.label);
      
      expect(cardTile.isSelected, isFalse);
      expect(interacTile.isSelected, isTrue);
    });

    testWidgets('should navigate to card details when continue is tapped with card selected', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Select card payment method
      await tester.tap(find.text(PaymentMethod.card.label));
      await tester.pump();
      
      // Tap continue button
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      
      // Assert navigation occurred (CardDetailsScreen should be present)
      expect(find.byType(CardDetailsScreen), findsOneWidget);
    });

    testWidgets('should not navigate when continue is tapped without selection', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: PaymentMethodScreen(),
        ),
      );
      
      // Try to tap continue button (should be disabled)
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.isDisabled, isTrue);
      
      // Verify we're still on the payment method screen
      expect(find.byType(PaymentMethodScreen), findsOneWidget);
      expect(find.byType(CardDetailsScreen), findsNothing);
    });
  });
}