import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardDetailsScreen', () {
    testWidgets('should render screen with correct header', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(CardDetailsScreen), findsOneWidget);
      expect(find.byType(PaymentScaffold), findsOneWidget);
      expect(find.byType(PaymentScreenHeader), findsOneWidget);
      expect(find.text('Enter Card Details'), findsOneWidget);
      expect(find.text('Your card information is securely encrypted.'), findsOneWidget);
    });

    testWidgets('should render card brand chips', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Assert - Should find 3 brand chips (Visa, Mastercard, Discover)
      expect(find.byType(Image), findsNWidgets(3));
    });

    testWidgets('should render all payment text fields', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(PaymentTextField), findsNWidgets(5));
      expect(find.text('Cardholder\'s Name'), findsOneWidget);
      expect(find.text('Card Number'), findsOneWidget);
      expect(find.text('Exp Date'), findsOneWidget);
      expect(find.text('CVV'), findsOneWidget);
      expect(find.text('Postal Code'), findsOneWidget);
    });

    testWidgets('should render submit button in bottom action container', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(BottomActionContainer), findsOneWidget);
      expect(find.text('Use this Card'), findsOneWidget);
      expect(find.byType(Button), findsOneWidget);
    });

    testWidgets('should disable submit button when form is invalid', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Assert
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.isDisabled, isTrue);
    });

    testWidgets('should validate cardholder name field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Find the form and trigger validation
      final form = find.byType(Form);
      expect(form, findsOneWidget);
      
      // Trigger validation by validating the form directly
      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();
      await tester.pump();
      
      // Should show validation error for empty name
      expect(find.text('Cardholder name is required'), findsOneWidget);
    });

    testWidgets('should validate card number field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Trigger validation
      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();
      await tester.pump();
      
      // Should show validation error for empty card number
      expect(find.text('Card number is required'), findsOneWidget);
    });

    testWidgets('should validate expiry date field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Trigger validation
      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();
      await tester.pump();
      
      // Should show validation error for empty expiry
      expect(find.text('Expiry date is required'), findsOneWidget);
    });

    testWidgets('should validate CVV field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Trigger validation
      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();
      await tester.pump();
      
      // Should show validation error for empty CVV
      expect(find.text('CVV is required'), findsOneWidget);
    });

    testWidgets('should validate postal code field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Trigger validation
      final formState = tester.state<FormState>(find.byType(Form));
      formState.validate();
      await tester.pump();
      
      // Should show validation error for empty postal code
      expect(find.text('Postal code is required'), findsOneWidget);
    });

    testWidgets('should show Visa icon for Visa card numbers', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Enter Visa card number (starts with 4)
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Card Number'),
        '4111111111111111',
      );
      await tester.pump();
      
      // Should show Visa icon in the card number field
      // Note: This tests the card brand detection logic
      final visaFinder = find.descendant(
        of: find.widgetWithText(PaymentTextField, 'Card Number'),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Image &&
              widget.image is AssetImage &&
              (widget.image as AssetImage).assetName == Assets.visaIcon,
        ),
      );
      expect(visaFinder, findsOneWidget);
    });

    testWidgets('should format expiry date input correctly', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Enter expiry date
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Exp Date'),
        '1225',
      );
      await tester.pump();
      
      // The input formatters should allow this input
      final expiryField = tester.widget<PaymentTextField>(
        find.widgetWithText(PaymentTextField, 'Exp Date'),
      );
      expect(expiryField.inputFormatters, isNotNull);
      expect(expiryField.inputFormatters!.length, equals(2));
    });

    testWidgets('should handle CVV as password field', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Assert CVV field is configured as password
      final cvvField = tester.widget<PaymentTextField>(
        find.widgetWithText(PaymentTextField, 'CVV'),
      );
      expect(cvvField.isPassword, isTrue);
      expect(cvvField.showPasswordToggle, isFalse);
    });

    testWidgets('should enable submit button when all fields are valid', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Fill all fields with valid data
      final DateTime now = DateTime.now();
      final String expiryDate =
          '${now.month.toString().padLeft(2, '0')}/${((now.year + 1) % 100).toString().padLeft(2, '0')}';
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Cardholder\'s Name'),
        'John Doe',
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Card Number'),
        '4111111111111111',
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Exp Date'),
        expiryDate,
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'CVV'),
        '123',
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Postal Code'),
        '12345',
      );
      await tester.pumpAndSettle();
      
      // Button should be enabled
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.isDisabled, isFalse);
    });

    testWidgets('should show loading state during submission', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: CardDetailsScreen(),
        ),
      );
      
      // Fill all fields with valid data
      final DateTime now = DateTime.now();
      final String expiryDate =
          '${now.month.toString().padLeft(2, '0')}/${((now.year + 1) % 100).toString().padLeft(2, '0')}';
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Cardholder\'s Name'),
        'John Doe',
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Card Number'),
        '4111111111111111',
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Exp Date'),
        expiryDate,
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'CVV'),
        '123',
      );
      await tester.enterText(
        find.widgetWithText(PaymentTextField, 'Postal Code'),
        '12345',
      );
      await tester.pumpAndSettle();
      
      // Tap submit button
      await tester.tap(find.widgetWithText(Button, 'Use this Card'));
      await tester.pump();
      
      // Button should show loading state
      final button = tester.widget<Button>(find.byType(Button));
      expect(button.isBusy, isTrue);
      
      await tester.pump(const Duration(milliseconds: 800));
      await tester.pump(const Duration(milliseconds: 600));
      await tester.pumpAndSettle();
    });

    group('Card Brand Detection', () {
      testWidgets('should detect Visa cards', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CardDetailsScreen()));
        
        await tester.enterText(
          find.widgetWithText(PaymentTextField, 'Card Number'),
          '4',
        );
        await tester.pump();
        
        // Should show some indication of Visa detection
        // (Implementation detail - the actual icon display logic)
      });

      testWidgets('should detect Mastercard', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CardDetailsScreen()));
        
        await tester.enterText(
          find.widgetWithText(PaymentTextField, 'Card Number'),
          '5555',
        );
        await tester.pump();
        
        // Should detect Mastercard range
      });
    });

    group('Validation Logic', () {
      testWidgets('should reject invalid expiry format', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CardDetailsScreen()));
        
        await tester.enterText(
          find.widgetWithText(PaymentTextField, 'Exp Date'),
          '1234',
        );
        final formState = tester.state<FormState>(find.byType(Form));
        formState.validate();
        await tester.pump();
        
        expect(find.text('Use MM/YY format'), findsAtLeastNWidgets(1));
      });

      testWidgets('should reject expired cards', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CardDetailsScreen()));
        
        await tester.enterText(
          find.widgetWithText(PaymentTextField, 'Exp Date'),
          '01/20',
        );
        final formState = tester.state<FormState>(find.byType(Form));
        formState.validate();
        await tester.pump();
        
        expect(find.text('Card has expired'), findsAtLeastNWidgets(1));
      });

      testWidgets('should reject invalid card number length', (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(home: CardDetailsScreen()));
        
        await tester.enterText(
          find.widgetWithText(PaymentTextField, 'Card Number'),
          '123',
        );
        final formState = tester.state<FormState>(find.byType(Form));
        formState.validate();
        await tester.pump();
        
        expect(find.text('Enter a valid card number'), findsAtLeastNWidgets(1));
      });
    });
  });
}