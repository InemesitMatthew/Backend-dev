import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: context.all(15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F0F0) : Palette.surface,
          borderRadius: .circular(12),
          border: .all(
            color: isSelected
                ? Palette.black
                : Palette.border2.withValues(alpha: 0.2),
            width: 0.75,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: .circle,
                border: .all(
                  color: isSelected
                      ? Palette.primary
                      : Palette.border2.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 8.33,
                        height: 8.33,
                        decoration: const BoxDecoration(
                          color: Palette.primary,
                          shape: .circle,
                        ),
                      ),
                    )
                  : null,
            ),
            context.horizontalSpace(10),
            TextWidget(
              label,
              fontSize: 14,
              fontWeight: .w500,
              textColor: Palette.black,
            ),
          ],
        ),
      ),
    );
  }
}
