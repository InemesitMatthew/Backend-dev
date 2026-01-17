/// Payment Flow Test Suite
/// 
/// Comprehensive test coverage for all payment flow components
/// including widgets, screens, and business logic.
/// 
/// Test Categories:
/// - Widget Tests: UI component behavior and rendering
/// - Screen Tests: Full screen integration and user flows
/// - Unit Tests: Business logic and validation
/// 
/// Coverage Goals:
/// - Widget Components: 90%+
/// - Screen Components: 85%+
/// - Business Logic: 95%+

import 'package:flutter_test/flutter_test.dart';

// Widget Tests
import 'presentation/widgets/bottom_action_container_test.dart' as bottom_action_container_tests;
import 'presentation/widgets/payment_screen_header_test.dart' as payment_screen_header_tests;
import 'presentation/widgets/payment_text_field_test.dart' as payment_text_field_tests;
import 'presentation/widgets/payment_scaffold_test.dart' as payment_scaffold_tests;

// Screen Tests
import 'presentation/screens/apartment_details_screen_test.dart' as apartment_details_screen_tests;
import 'presentation/screens/payment_method_screen_test.dart' as payment_method_screen_tests;
import 'presentation/screens/card_details_screen_test.dart' as card_details_screen_tests;

void main() {
  group('Payment Flow Test Suite', () {
    group('Widget Tests', () {
      group('BottomActionContainer', bottom_action_container_tests.main);
      group('PaymentScreenHeader', payment_screen_header_tests.main);
      group('PaymentTextField', payment_text_field_tests.main);
      group('PaymentScaffold', payment_scaffold_tests.main);
    });

    group('Screen Tests', () {
      group('ApartmentDetailsScreen', apartment_details_screen_tests.main);
      group('PaymentMethodScreen', payment_method_screen_tests.main);
      group('CardDetailsScreen', card_details_screen_tests.main);
    });
  });
}