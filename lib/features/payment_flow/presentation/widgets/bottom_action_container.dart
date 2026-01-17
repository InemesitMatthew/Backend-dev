import 'package:backend_dev/core/core.dart';

class BottomActionContainer extends StatelessWidget {
  const BottomActionContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.surface,
        border: Border(
          top: BorderSide(
            color: Palette.border2.withValues(alpha: 0.2),
            width: 0.75,
          ),
        ),
      ),
      child: Padding(
        padding: padding ?? context.symmetric(horizontal: 16, vertical: 10),
        child: child,
      ),
    );
  }
}
