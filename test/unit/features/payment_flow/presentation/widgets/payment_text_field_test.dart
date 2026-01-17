import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PaymentTextField', () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('should render with basic configuration', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Card Number';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
            ),
          ),
        ),
      );
      
      // Assert
      expect(find.byType(PaymentTextField), findsOneWidget);
      expect(find.byType(TextFieldWidget), findsOneWidget);
    });

    testWidgets('should show hint text when controller is empty', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Card Number';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.hintText, equals(labelText));
      expect(textField.labelText, isNull);
    });

    testWidgets('should show label text when controller has text', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Card Number';
      controller.text = '1234';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.labelText, equals(labelText));
      expect(textField.hintText, isNull);
    });

    testWidgets('should use custom hint text when provided', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Card Number';
      const hintText = 'Enter your card number';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
              hintText: hintText,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.hintText, equals(hintText));
    });

    testWidgets('should apply correct styling configuration', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Test Field';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      
      expect(textField.floatingLabelBehavior, equals(FloatingLabelBehavior.always));
      expect(textField.isLabelInside, isTrue);
      expect(textField.hintFontSize, equals(14));
      expect(textField.textFontSize, equals(14));
      expect(textField.textFontWeight, equals(FontWeight.w600));
      expect(textField.contentPadding, equals(const EdgeInsets.all(12)));
      expect(textField.fieldHeight, equals(48));
      expect(textField.borderRadius, equals(8));
      expect(textField.borderWidth, equals(1));
      expect(textField.focusedBorderColor, equals(Palette.textPrimary));
      expect(textField.focusedBorderWidth, equals(1));
      expect(textField.reserveErrorSpace, isTrue);
    });

    testWidgets('should handle keyboard type configuration', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Phone Number';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
              keyboardType: TextInputType.phone,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.keyboardType, equals(TextInputType.phone));
    });

    testWidgets('should handle input formatters', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Card Number';
      final formatters = [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(16),
      ];
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
              inputFormatters: formatters,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.inputFormatters, equals(formatters));
    });

    testWidgets('should handle password configuration', (WidgetTester tester) async {
      // Arrange
      const labelText = 'CVV';
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
              isPassword: true,
              showPasswordToggle: false,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.isPassword, isTrue);
      expect(textField.showPasswordToggle, isFalse);
    });

    testWidgets('should handle suffix widget', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Card Number';
      const suffixWidget = Icon(Icons.credit_card);
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PaymentTextField(
              controller: controller,
              labelText: labelText,
              suffix: suffixWidget,
            ),
          ),
        ),
      );
      
      // Assert
      final textField = tester.widget<TextFieldWidget>(find.byType(TextFieldWidget));
      expect(textField.suffix, equals(suffixWidget));
      expect(find.byIcon(Icons.credit_card), findsOneWidget);
    });

    testWidgets('should call validator function', (WidgetTester tester) async {
      // Arrange
      const labelText = 'Test Field';
      final formKey = GlobalKey<FormState>();
      bool validatorCalled = false;
      String? validatorValue;
      
      String? testValidator(String? value) {
        validatorCalled = true;
        validatorValue = value;
        return value?.isEmpty == true ? 'Required' : null;
      }
      
      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: PaymentTextField(
                controller: controller,
                labelText: labelText,
                validator: testValidator,
              ),
            ),
          ),
        ),
      );
      
      // Trigger validation
      formKey.currentState!.validate();
      
      // Assert
      expect(validatorCalled, isTrue);
      expect(validatorValue, equals(''));
    });
  });
}