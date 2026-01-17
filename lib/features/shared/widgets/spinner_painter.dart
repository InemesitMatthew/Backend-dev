import 'dart:math' as math;

import 'package:backend_dev/core/core.dart';

/// Paints a radial set of bars for the loading spinner.
class SpinnerPainter extends CustomPainter {
  /// Creates the spinner painter.
  const SpinnerPainter({required this.color, required this.barCount})
    : assert(barCount > 0, 'barCount must be greater than zero.');
  final Color color;
  final int barCount;
  @override
  void paint(Canvas canvas, Size size) {
    final double shortestSide = size.shortestSide;
    final double barWidth = shortestSide * 0.05;
    final double barLength = shortestSide * 0.12;
    final double radius = shortestSide * 0.30;
    final double angleStep = (2 * math.pi) / barCount;
    final Offset center = size.center(Offset.zero);
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = barWidth
      ..strokeCap = StrokeCap.round;
    for (int index = 0; index < barCount; index += 1) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angleStep * index);
      final Offset start = Offset(0, -radius);
      final Offset end = Offset(0, -radius + barLength);
      canvas.drawLine(start, end, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(SpinnerPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.barCount != barCount;
  }
}
