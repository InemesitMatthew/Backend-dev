import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class PaymentScreenHeader extends StatelessWidget {
  const PaymentScreenHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        TextWidget(
          title,
          fontSize: 32,
          fontWeight: .w500,
          textColor: Palette.black,
          fontFamily: AppFontFamily.redwing,
        ),
        if (subtitle != null) ...[
          context.verticalSpace(8),
          TextWidget(
            subtitle!,
            fontSize: 14,
            fontWeight: .w400,
            textColor: Palette.black.withValues(alpha: 0.6),
          ),
        ],
      ],
    );
  }
}
