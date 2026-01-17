import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class Button extends StatefulWidget {
  const Button({
    super.key,
    required this.onTap,
    this.title,
    this.child,
    this.leading,
    this.trailing,
    this.filled = true,
    this.isBusy = false,
    this.isDisabled = false,
    this.animateOnTap = true,
    this.shadow = false,
    this.color,
    this.textColor,
    this.width,
    this.height = 45,
    this.padding,
    this.borderRadius = 8,
    this.textStyle,
    this.hasInfiniteWidth = true,
    this.fontSize = 14,
    this.textHeight = 1,
    this.fontWeight = .w600,
  });

  final VoidCallback? onTap;
  final String? title;
  final Widget? child;
  final Widget? leading;
  final Widget? trailing;
  final bool filled;
  final bool isBusy;
  final bool isDisabled;
  final bool animateOnTap;
  final bool shadow;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double height;
  final EdgeInsets? padding;
  final double borderRadius;
  final TextStyle? textStyle;
  final bool hasInfiniteWidth;
  final double fontSize;
  final double textHeight;
  final FontWeight fontWeight;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool _isPressed = false;

  bool _isInteractive() => !widget.isDisabled && !widget.isBusy;

  void _handleTapDown(TapDownDetails details) {
    if (!widget.animateOnTap) return;
    if (!_isInteractive()) return;
    setState(() => _isPressed = true);
  }

  void _handleTapEnd([TapUpDetails? details]) {
    if (!widget.animateOnTap) return;
    if (!_isPressed) return;
    setState(() => _isPressed = false);
  }

  void _handleTapCancel() {
    if (!widget.animateOnTap) return;
    if (!_isPressed) return;
    setState(() => _isPressed = false);
  }

  Color _resolveBackgroundColor() {
    if (!widget.filled) return Colors.transparent;
    if (widget.isDisabled || widget.isBusy) return Palette.primaryMuted;
    return widget.color ?? Palette.primary;
  }

  Color _resolveTextColor() {
    if (widget.textColor != null) return widget.textColor!;
    if (!widget.filled) return widget.color ?? Palette.textPrimary;
    if (widget.isDisabled || widget.isBusy) return Palette.surface;
    return Palette.surface;
  }

  Color _resolveBorderColor() {
    if (widget.filled) return Colors.transparent;
    return widget.color ?? Palette.border2.withValues(alpha: 0.15);
  }

  Widget _buildText() {
    if (widget.textStyle != null) {
      return Text(
        widget.title ?? '',
        style: widget.textStyle!.copyWith(color: _resolveTextColor()),
      );
    }
    return TextWidget(
      widget.title ?? '',
      textColor: _resolveTextColor(),
      fontSize: widget.fontSize,
      fontWeight: widget.fontWeight,
      height: widget.textHeight,
    );
  }

  Widget _buildTitle() {
    if (widget.child != null) return widget.child!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.leading != null) ...[
          widget.leading!,
          const SizedBox(width: 8),
        ],
        if (widget.isBusy)
          SizedBox(
            height: 18,
            width: 18,
            child: CupertinoActivityIndicator(color: _resolveTextColor()),
          )
        else
          Flexible(
            child: FittedBox(fit: BoxFit.contain, child: _buildText()),
          ),
        if (widget.trailing != null) ...[
          const SizedBox(width: 8),
          widget.trailing!,
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double? resolvedWidth = widget.hasInfiniteWidth ? null : widget.width;
    return GestureDetector(
      onTap: _isInteractive() ? widget.onTap : null,
      onTapDown: _handleTapDown,
      onTapUp: _handleTapEnd,
      onTapCancel: _handleTapCancel,
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _isPressed ? 0.98 : 1,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: resolvedWidth,
          height: widget.height,
          padding: widget.padding ?? context.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: _resolveBackgroundColor(),
            borderRadius: .circular(widget.borderRadius),
            border: Border.all(color: _resolveBorderColor()),
            boxShadow: widget.shadow && _isInteractive()
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Center(child: _buildTitle()),
        ),
      ),
    );
  }
}
