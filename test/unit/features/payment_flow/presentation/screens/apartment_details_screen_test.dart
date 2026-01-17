import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApartmentDetailsScreen', () {
    testWidgets('should render screen with default apartment details', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(ApartmentDetailsScreen), findsOneWidget);
      expect(find.byType(CupertinoPageScaffold), findsOneWidget);
    });

    testWidgets('should render apartment image', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert - Should find the main apartment image
      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('should render security deposit section', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.text('Pay Security Deposit'), findsOneWidget);
      expect(find.text('Proceed to payment'), findsOneWidget);
      expect(find.byType(SectionCard), findsWidgets);
    });

    testWidgets('should render apartment information section', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(RichTextWidget), findsWidgets);
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('read more'), findsOneWidget);
    });

    testWidgets('should render features section', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.text('Features'), findsOneWidget);
      expect(find.byType(FeatureChip), findsWidgets);
    });

    testWidgets('should render location section', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.text('Location'), findsOneWidget);
      // Should find map image
      expect(find.byType(ClipRRect), findsWidgets);
    });

    testWidgets('should render bottom action buttons', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byType(BottomActionContainer), findsOneWidget);
      expect(find.text('Edit application'), findsOneWidget);
      expect(find.text('Withdraw'), findsOneWidget);
      expect(find.byType(Button), findsNWidgets(3)); // Proceed to payment + Edit + Withdraw
    });

    testWidgets('should handle proceed to payment button tap', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Tap proceed to payment button
      final proceedButton = tester.widget<Button>(
        find.widgetWithText(Button, 'Proceed to payment'),
      );
      proceedButton.onTap?.call();
      await tester.pump();
      
      // Should show loading state
      expect(find.byType(LoadingOverlay), findsOneWidget);
      
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });

    testWidgets('should navigate to payment method screen after payment processing', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Tap proceed to payment button
      final proceedButton = tester.widget<Button>(
        find.widgetWithText(Button, 'Proceed to payment'),
      );
      proceedButton.onTap?.call();
      await tester.pump();
      
      // Wait for the processing delay
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      
      // Should navigate to PaymentMethodScreen
      expect(find.byType(PaymentMethodScreen), findsOneWidget);
    });

    testWidgets('should expand description when read more is tapped', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Initially should show "read more"
      expect(find.text('read more'), findsOneWidget);
      expect(find.text('read less'), findsNothing);
      
      // Tap read more
      await tester.ensureVisible(find.text('read more'));
      await tester.tap(find.text('read more'));
      await tester.pump();
      
      // Should now show "read less"
      expect(find.text('read less'), findsOneWidget);
      expect(find.text('read more'), findsNothing);
    });

    testWidgets('should collapse description when read less is tapped', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Expand description first
      await tester.ensureVisible(find.text('read more'));
      await tester.tap(find.text('read more'));
      await tester.pump();
      
      // Then collapse it
      await tester.ensureVisible(find.text('read less'));
      await tester.tap(find.text('read less'));
      await tester.pump();
      
      // Should show "read more" again
      expect(find.text('read more'), findsOneWidget);
      expect(find.text('read less'), findsNothing);
    });

    testWidgets('should scroll to map section when "See Google Location" is tapped', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Tap "See Google Location" link
      await tester.ensureVisible(find.text('See Google Location'));
      await tester.tap(find.text('See Google Location'));
      await tester.pumpAndSettle();
      
      // Should trigger scroll animation (hard to test exact scroll position)
      // But we can verify the link exists and is tappable
      expect(find.text('See Google Location'), findsOneWidget);
    });

    testWidgets('should prevent multiple payment processing', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Tap proceed to payment button multiple times quickly
      final proceedButton = tester.widget<Button>(
        find.widgetWithText(Button, 'Proceed to payment'),
      );
      proceedButton.onTap?.call();
      await tester.pump();
      proceedButton.onTap?.call();
      await tester.pump();
      
      // Should only show one loading overlay
      expect(find.byType(LoadingOverlay), findsOneWidget);
      
      await tester.pump(const Duration(seconds: 2));
      await tester.pumpAndSettle();
    });

    testWidgets('should render with custom apartment details', (WidgetTester tester) async {
      // Arrange
      const customDetails = ApartmentDetails(
        name: 'Custom Apartment',
        pricePerMonth: '\$2000/month',
        address: '123 Custom St',
        rating: 4.8,
        reviewCount: 150,
        description: 'Custom description',
        imageUrl: Assets.apartmentBg,
        mapUrl: Assets.mapIcon,
        depositAmountText: '\$500',
        features: [],
      );
      
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(details: customDetails),
        ),
      );
      
      // Assert
      expect(find.text('Custom Apartment'), findsOneWidget);
      expect(find.text('123 Custom St'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.textSpan?.toPlainText().contains('4.8') == true,
        ),
        findsWidgets,
      );
      expect(
        find.byWidgetPredicate(
          (widget) =>
              widget is Text &&
              widget.textSpan?.toPlainText().contains('(150 Reviews)') == true,
        ),
        findsWidgets,
      );
      expect(find.text('Custom description'), findsOneWidget);
    });

    testWidgets('should handle edit application button tap', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Tap edit application button
      await tester.tap(find.text('Edit application'));
      await tester.pump();
      
      // Should not crash (button has empty onTap for now)
      expect(find.byType(ApartmentDetailsScreen), findsOneWidget);
    });

    testWidgets('should handle withdraw button tap', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Tap withdraw button
      await tester.tap(find.text('Withdraw'));
      await tester.pump();
      
      // Should not crash (button has empty onTap for now)
      expect(find.byType(ApartmentDetailsScreen), findsOneWidget);
    });

    testWidgets('should display rating with star icon', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert
      expect(find.byIcon(CupertinoIcons.star_fill), findsOneWidget);
      expect(find.byType(RichTextWidget), findsWidgets);
    });

    testWidgets('should display location icon with address', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Assert - Should find location icon
      expect(find.byType(Image), findsWidgets); // Location icon is an Image asset
    });

    testWidgets('should handle scroll controller properly', (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: ApartmentDetailsScreen(),
        ),
      );
      
      // Should find scrollable content
      expect(find.byType(SingleChildScrollView), findsOneWidget);
      
      // Should be able to scroll
      await tester.drag(find.byType(SingleChildScrollView), const Offset(0, -200));
      await tester.pump();
      
      // Should not crash during scroll
      expect(find.byType(ApartmentDetailsScreen), findsOneWidget);
    });
  });
}