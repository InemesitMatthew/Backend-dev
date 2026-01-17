import 'package:backend_dev/core/core.dart';

class SafeNetworkImage extends StatelessWidget {
  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    required this.height,
    this.fit = .cover,
    this.borderRadius = 0,
  });

  final String imageUrl;
  final double height;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return _ImagePlaceholder(height: height, borderRadius: borderRadius);
    }
    final Widget image = Image.network(
      imageUrl,
      height: height,
      width: .infinity,
      fit: fit,
      errorBuilder: (_, _, _) =>
          _ImagePlaceholder(height: height, borderRadius: borderRadius),
    );
    return borderRadius == 0
        ? image
        : ClipRRect(
            borderRadius: .circular(borderRadius),
            child: image,
          );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.height, required this.borderRadius});

  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final Widget content = Container(
      height: height,
      width: .infinity,
      color: Palette.border,
      child: const Center(
        child: Icon(
          CupertinoIcons.photo,
          color: Palette.primaryMuted,
          size: 32,
        ),
      ),
    );
    return borderRadius == 0
        ? content
        : ClipRRect(
            borderRadius: .circular(borderRadius),
            child: content,
          );
  }
}
