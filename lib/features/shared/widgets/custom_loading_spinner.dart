import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

/// Animated spinner with rotating bars.
class CustomLoadingSpinner extends StatefulWidget {
  /// Creates a configurable loading spinner.
  const CustomLoadingSpinner({
    super.key,
    this.size = 22,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1500),
    this.barCount = 8,
  });
  final double size;
  final Color color;
  final Duration duration;
  final int barCount;
  @override
  State<CustomLoadingSpinner> createState() => _CustomLoadingSpinnerState();
}

class _CustomLoadingSpinnerState extends State<CustomLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _rotation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
    _rotation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }
  @override
  void didUpdateWidget(CustomLoadingSpinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration) {
      _controller
        ..duration = widget.duration
        ..reset()
        ..repeat();
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: RotationTransition(
        turns: _rotation,
        child: CustomPaint(
          painter: SpinnerPainter(
            color: widget.color,
            barCount: widget.barCount,
          ),
        ),
      ),
    );
  }
}
