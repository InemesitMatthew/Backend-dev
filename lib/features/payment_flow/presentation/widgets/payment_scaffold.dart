import 'package:backend_dev/core/core.dart';

class PaymentScaffold extends StatelessWidget {
  const PaymentScaffold({
    super.key,
    required this.body,
    this.showBackButton = true,
    this.onBackPressed,
  });

  final Widget body;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Palette.surface,
      navigationBar: showBackButton
          ? CupertinoNavigationBar(
              leading: GestureDetector(
                onTap: onBackPressed ?? () => Navigator.of(context).maybePop(),
                child: const Icon(CupertinoIcons.back, size: 24),
              ),
            )
          : null,
      child: SafeArea(top: false, child: body),
    );
  }
}
