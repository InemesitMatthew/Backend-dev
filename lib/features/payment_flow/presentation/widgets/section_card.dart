import 'package:backend_dev/core/core.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.symmetric(vertical: 12, horizontal: 11),
      decoration: BoxDecoration(
        color: Palette.surface,
        borderRadius: .circular(16),
        border: .all(
          color: const Color(0x00363636).withValues(alpha: 0.2),
          width: 0.75,
        ),
      ),
      child: child,
    );
  }
}
