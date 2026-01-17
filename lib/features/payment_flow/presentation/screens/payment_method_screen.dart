import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});
  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentMethod? _selectedMethod;
  void _selectMethod(PaymentMethod method) {
    setState(() {
      _selectedMethod = method;
    });
  }

  void _continue() {
    if (_selectedMethod == null) {
      return;
    }
    if (_selectedMethod == PaymentMethod.card) {
      Navigator.of(context).push(
        CupertinoPageRoute<Widget>(
          builder: (BuildContext context) {
            return const CardDetailsScreen();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PaymentScaffold(
      body: Column(
        crossAxisAlignment: .start,
        children: [
          Expanded(
            child: Padding(
              padding: context.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  const PaymentScreenHeader(
                    title: 'Payment Method',
                    subtitle: 'Please select your payment method.',
                  ),
                  context.verticalSpace(24),
                  PaymentMethodTile(
                    label: PaymentMethod.card.label,
                    isSelected: _selectedMethod == PaymentMethod.card,
                    onTap: () => _selectMethod(PaymentMethod.card),
                  ),
                  context.verticalSpace(12),
                  PaymentMethodTile(
                    label: PaymentMethod.interac.label,
                    isSelected: _selectedMethod == PaymentMethod.interac,
                    onTap: () => _selectMethod(PaymentMethod.interac),
                  ),
                ],
              ),
            ),
          ),
          BottomActionContainer(
            child: SizedBox(
              width: .infinity,
              child: Button(
                title: 'Continue',
                onTap: _continue,
                isDisabled: _selectedMethod == null,
              ),
            ),
          ),
          context.verticalSpace(12),
        ],
      ),
    );
  }
}
