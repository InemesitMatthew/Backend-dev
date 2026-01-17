import 'package:backend_dev/core/core.dart';

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.size = 36,
    this.backgroundColor = Palette.surface,
    this.iconColor = Palette.primary,
  });

  final IconData icon;
  final VoidCallback onTap;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: .circle,
        ),
        child: Icon(icon, color: iconColor),
      ),
    );
  }
}
