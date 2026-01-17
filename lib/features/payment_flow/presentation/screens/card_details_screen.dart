import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class CardDetailsScreen extends StatefulWidget {
  const CardDetailsScreen({super.key});
  @override
  State<CardDetailsScreen> createState() => _CardDetailsScreenState();
}

class _CardDetailsScreenState extends State<CardDetailsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  late final TextEditingController _nameController;
  late final TextEditingController _numberController;
  late final TextEditingController _expiryController;
  late final TextEditingController _cvvController;
  late final TextEditingController _postalController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController()..addListener(_updateState);
    _numberController = TextEditingController()..addListener(_updateState);
    _expiryController = TextEditingController()..addListener(_updateState);
    _cvvController = TextEditingController()..addListener(_updateState);
    _postalController = TextEditingController()..addListener(_updateState);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _postalController.dispose();
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  String _digitsOnly(String value) {
    return value.replaceAll(RegExp(r'[^0-9]'), '');
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Cardholder name is required';
    }
    return null;
  }

  String? _validateCardNumber(String? value) {
    final String digits = _digitsOnly(value ?? '');
    if (digits.isEmpty) {
      return 'Card number is required';
    }
    if (digits.length < 13 || digits.length > 19) {
      return 'Enter a valid card number';
    }
    return null;
  }

  String? _validateExpiry(String? value) {
    final String text = value?.trim() ?? '';
    final RegExp exp = RegExp(r'^(\d{2})/(\d{2})$');
    final RegExpMatch? match = exp.firstMatch(text);
    if (text.isEmpty) {
      return 'Expiry date is required';
    }
    if (match == null) {
      return 'Use MM/YY format';
    }
    final int month = int.parse(match.group(1)!);
    final int year = int.parse(match.group(2)!);
    if (month < 1 || month > 12) {
      return 'Invalid month';
    }
    final DateTime now = DateTime.now();
    final int fullYear = 2000 + year;
    final DateTime expiryDate = DateTime(fullYear, month + 1);
    if (expiryDate.isBefore(DateTime(now.year, now.month + 1))) {
      return 'Card has expired';
    }
    return null;
  }

  String? _validateCvv(String? value) {
    final String digits = _digitsOnly(value ?? '');
    if (digits.isEmpty) {
      return 'CVV is required';
    }
    if (digits.length < 3 || digits.length > 4) {
      return 'Enter a valid CVV';
    }
    return null;
  }

  String? _validatePostal(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }
    return null;
  }

  String? _cardBrandAsset(String value) {
    final String digits = _digitsOnly(value);
    if (digits.isEmpty) {
      return null;
    }
    if (digits.startsWith('4')) {
      return Assets.visaIcon;
    }
    final int? firstTwo = digits.length >= 2
        ? int.tryParse(digits.substring(0, 2))
        : null;
    final int? firstFour = digits.length >= 4
        ? int.tryParse(digits.substring(0, 4))
        : null;
    final int? firstThree = digits.length >= 3
        ? int.tryParse(digits.substring(0, 3))
        : null;
    if (firstTwo != null && firstTwo >= 51 && firstTwo <= 55) {
      return Assets.mastercardIcon;
    }
    if (firstFour != null && firstFour >= 2221 && firstFour <= 2720) {
      return Assets.mastercardIcon;
    }
    if (digits.startsWith('6011')) {
      return Assets.discoverIcon;
    }
    if (digits.startsWith('65')) {
      return Assets.discoverIcon;
    }
    if (firstThree != null && firstThree >= 644 && firstThree <= 649) {
      return Assets.discoverIcon;
    }
    return null;
  }

  Future<void> _submit() async {
    if (_isSubmitting) {
      return;
    }
    FocusScope.of(context).unfocus();
    final bool isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    setState(() {
      _isSubmitting = true;
    });
    await Future<void>.delayed(const Duration(milliseconds: 800));
    if (!mounted) {
      return;
    }
    _scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('Card details saved successfully'),
        duration: Duration(milliseconds: 1200),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) {
      return;
    }
    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute<Widget>(
        builder: (BuildContext context) {
          return const ApartmentDetailsScreen();
        },
      ),
      (Route<dynamic> route) => false,
    );
    setState(() {
      _isSubmitting = false;
    });
  }

  bool get _isFormValid {
    return _validateName(_nameController.text) == null &&
        _validateCardNumber(_numberController.text) == null &&
        _validateExpiry(_expiryController.text) == null &&
        _validateCvv(_cvvController.text) == null &&
        _validatePostal(_postalController.text) == null;
  }

  @override
  Widget build(BuildContext context) {
    final String? cardBrandAsset = _cardBrandAsset(_numberController.text);
    return PaymentScaffold(
      body: ScaffoldMessenger(
        key: _scaffoldMessengerKey,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: context.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        const PaymentScreenHeader(
                          title: 'Enter Card Details',
                          subtitle:
                              'Your card information is securely encrypted.',
                        ),
                        context.verticalSpace(16),
                        Row(
                          children: [
                            const _BrandChip(assetPath: Assets.visaIcon),
                            context.horizontalSpace(10),
                            const _BrandChip(assetPath: Assets.mastercardIcon),
                            context.horizontalSpace(10),
                            const _BrandChip(assetPath: Assets.discoverIcon),
                          ],
                        ),
                        context.verticalSpace(24),
                        // DESIGN DECISION
                        PaymentTextField(
                          controller: _nameController,
                          labelText: 'Cardholder\'s Name',
                          validator: _validateName,
                        ),
                        context.verticalSpace(4),
                        PaymentTextField(
                          controller: _numberController,
                          labelText: 'Card Number',
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(19),
                          ],
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: cardBrandAsset == null
                                ? const Icon(
                                    CupertinoIcons.creditcard,
                                    color: Palette.primaryMuted,
                                  )
                                : Image.asset(
                                    cardBrandAsset,
                                    height: 20,
                                    width: 32,
                                    fit: BoxFit.contain,
                                  ),
                          ),
                          validator: _validateCardNumber,
                        ),
                        context.verticalSpace(8),
                        Row(
                          children: [
                            Expanded(
                              child: PaymentTextField(
                                controller: _expiryController,
                                labelText: 'Exp Date',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9/]'),
                                  ),
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                validator: _validateExpiry,
                              ),
                            ),
                            context.horizontalSpace(12),
                            Expanded(
                              child: PaymentTextField(
                                controller: _cvvController,
                                labelText: 'CVV',
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(4),
                                ],
                                isPassword: true,
                                showPasswordToggle: false,
                                validator: _validateCvv,
                              ),
                            ),
                          ],
                        ),
                        context.verticalSpace(8),
                        PaymentTextField(
                          controller: _postalController,
                          labelText: 'Postal Code',
                          validator: _validatePostal,
                        ),
                        context.verticalSpace(24),
                      ],
                    ),
                  ),
                ),
              ),
              BottomActionContainer(
                child: SizedBox(
                  width: .infinity,
                  child: Button(
                    title: 'Use this Card',
                    onTap: _submit,
                    isDisabled: !_isFormValid || _isSubmitting,
                    isBusy: _isSubmitting,
                  ),
                ),
              ),
              context.verticalSpace(12),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrandChip extends StatelessWidget {
  const _BrandChip({required this.assetPath});
  final String assetPath;
  @override
  Widget build(BuildContext context) {
    return assetPath.isEmpty
        ? const Icon(
            CupertinoIcons.creditcard,
            size: 26,
            color: Palette.primaryMuted,
          )
        : Image.asset(assetPath, height: 26, width: 43, fit: .contain);
  }
}
