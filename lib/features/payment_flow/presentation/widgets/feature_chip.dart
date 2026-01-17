import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class FeatureChip extends StatelessWidget {
  const FeatureChip({super.key, required this.label, required this.iconAsset});
  final String label;
  final String iconAsset;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.symmetric(vertical: 16, horizontal: 11),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: .circular(16),
        border: .all(
          color: Palette.border2.withValues(alpha: 0.1),
          width: 0.75,
        ),
      ),
      child: Column(
        mainAxisSize: .min,
        children: [
          Image.asset(iconAsset, width: 20, height: 20, fit: .contain),
          context.verticalSpace(16),
          TextWidget(
            label,
            fontSize: 12,
            fontWeight: .w500,
            height: 1,
            textColor: Palette.black2,
            fontFamily: AppFontFamily.geist,
          ),
        ],
      ),
    );
  }
}
