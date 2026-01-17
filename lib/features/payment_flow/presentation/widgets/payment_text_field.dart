import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class PaymentTextField extends StatelessWidget {
  const PaymentTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.suffix,
    this.isPassword = false,
    this.showPasswordToggle = true,
  });

  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final bool isPassword;
  final bool showPasswordToggle;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      controller: controller,
      labelText: controller.text.isEmpty ? null : labelText,
      hintText: controller.text.isEmpty ? (hintText ?? labelText) : null,
      floatingLabelBehavior: .always,
      isLabelInside: true,
      hintFontSize: 14,
      textFontSize: 14,
      textFontWeight: .w600,
      contentPadding: context.all(12),
      fieldHeight: 48,
      borderRadius: 8,
      borderWidth: 1,
      focusedBorderColor: Palette.textPrimary,
      focusedBorderWidth: 1,
      reserveErrorSpace: true,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      suffix: suffix,
      isPassword: isPassword,
      showPasswordToggle: showPasswordToggle,
      validator: validator,
    );
  }
}
