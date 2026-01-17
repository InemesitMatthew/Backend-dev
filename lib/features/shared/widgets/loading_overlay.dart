import 'dart:ui';

import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

/// Full-screen overlay that blocks input and shows a spinner.
class LoadingOverlay extends StatelessWidget {
  /// Creates a loading overlay with a centered spinner.
  const LoadingOverlay({
    super.key,
    this.isVisible = false,
    this.size = 44,
    this.color = Colors.white,
    this.duration = const Duration(milliseconds: 1500),
    this.barCount = 8,
  });
  final bool isVisible;
  final double size;
  final Color color;
  final Duration duration;
  final int barCount;
  @override
  Widget build(BuildContext context) {
    if (!isVisible) {
      return const SizedBox.shrink();
    }
    final double containerSize = size + 16;
    return SizedBox.expand(
      child: AbsorbPointer(
        absorbing: true,
        child: Container(
          color: Colors.black.withValues(alpha: 0.2),
          child: Center(
            child: ClipRRect(
              borderRadius: .circular(containerSize * 0.22),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(
                  width: containerSize,
                  height: containerSize,
                  decoration: BoxDecoration(
                    color: const Color(0xFF3F3F3F).withValues(alpha: 0.5),
                    borderRadius: .circular(containerSize * 0.22),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                      width: 0.6,
                    ),
                  ),
                  child: Center(
                    child: CustomLoadingSpinner(
                      size: size,
                      color: color,
                      duration: duration,
                      barCount: barCount,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
