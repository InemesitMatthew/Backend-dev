import 'package:backend_dev/core/core.dart';

enum AppFontFamily { inter, geist, redwing }

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.textColor,
    this.fontWeight,
    this.textAlign = .start,
    this.maxLines,
    this.overflow,
    this.decoration,
    this.height,
    this.decorationColor,
    this.fontStyle,
    this.letterSpacing,
    this.fontFamily,
  });

  // Link-styled label text.
  factory TextWidget.link(
    String text, {
    Key? key,
    Color? textColor,
    AppFontFamily? fontFamily,
    TextDecoration decoration = .underline,
    double? fontSize,
  }) {
    final Color resolvedColor = textColor ?? Palette.linkBlue;
    return TextWidget(
      text,
      key: key,
      fontSize: fontSize ?? 12,
      fontWeight: .w600,
      textColor: resolvedColor,
      fontFamily: fontFamily,
      decoration: decoration,
      decorationColor: resolvedColor,
    );
  }

  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final TextDecoration? decoration;
  final double? height;
  final Color? decorationColor;
  final double? letterSpacing;
  final AppFontFamily? fontFamily;

  TextStyle _buildTextStyle(BuildContext context) {
    final AppFontFamily selectedFont = fontFamily ?? .inter;
    final String fontName = switch (selectedFont) {
      .inter => 'Inter',
      .geist => 'Geist',
      .redwing => 'Redwing',
    };
    final bool isAssetFont = selectedFont == .redwing || selectedFont == .geist;
    final TextStyle baseStyle = isAssetFont
        ? TextStyle(
            fontFamily: fontName,
            fontSize: context.sp(fontSize ?? 14),
            color: textColor ?? Palette.textBody,
            fontWeight: fontWeight ?? .normal,
            fontStyle: fontStyle,
            height: height,
            letterSpacing: letterSpacing,
          )
        : GoogleFonts.getFont(
            fontName,
            fontSize: context.sp(fontSize ?? 14),
            color: textColor ?? Palette.textBody,
            fontWeight: fontWeight ?? .normal,
            fontStyle: fontStyle,
            height: height,
            letterSpacing: letterSpacing,
          );
    return baseStyle.copyWith(
      decoration: decoration,
      decorationColor: decorationColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _buildTextStyle(context),
      textAlign: textAlign,
      overflow: overflow,
      softWrap: true,
      maxLines: maxLines,
    );
  }
}

class InlineEmphasisText extends StatelessWidget {
  const InlineEmphasisText({
    super.key,
    required this.prefix,
    required this.emphasis,
    required this.suffix,
    this.fontFamily,
    this.fontSize = 12,
    this.textColor,
    this.emphasisColor,
    this.fontWeight,
    this.emphasisWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  });

  final String prefix;
  final String emphasis;
  final String suffix;
  final AppFontFamily? fontFamily;
  final double fontSize;
  final Color? textColor;
  final Color? emphasisColor;
  final FontWeight? fontWeight;
  final FontWeight? emphasisWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final double? letterSpacing;

  TextStyle _buildTextStyle({
    required BuildContext context,
    required Color color,
    required FontWeight weight,
  }) {
    final AppFontFamily selectedFont = fontFamily ?? .inter;
    final String fontName = switch (selectedFont) {
      .inter => 'Inter',
      .geist => 'Geist',
      .redwing => 'Redwing',
    };
    final bool isAssetFont = selectedFont == .redwing || selectedFont == .geist;
    // Keep inline text consistent with app font sources.
    return isAssetFont
        ? TextStyle(
            fontFamily: fontName,
            fontSize: context.sp(fontSize),
            color: color,
            fontWeight: weight,
            height: height,
            letterSpacing: letterSpacing,
          )
        : GoogleFonts.getFont(
            fontName,
            fontSize: context.sp(fontSize),
            color: color,
            fontWeight: weight,
            height: height,
            letterSpacing: letterSpacing,
          );
  }

  @override
  Widget build(BuildContext context) {
    final Color resolvedTextColor = textColor ?? Palette.textSecondary;
    final Color resolvedEmphasisColor = emphasisColor ?? resolvedTextColor;
    final FontWeight resolvedWeight = fontWeight ?? .w400;
    final FontWeight resolvedEmphasisWeight = emphasisWeight ?? .w600;
    // Build base and emphasis styles to keep inline rendering clean.
    final TextStyle baseStyle = _buildTextStyle(
      context: context,
      color: resolvedTextColor,
      weight: resolvedWeight,
    );
    final TextStyle emphasisStyle = _buildTextStyle(
      context: context,
      color: resolvedEmphasisColor,
      weight: resolvedEmphasisWeight,
    );
    return Text.rich(
      TextSpan(
        text: prefix,
        style: baseStyle,
        children: <InlineSpan>[
          TextSpan(text: emphasis, style: emphasisStyle),
          TextSpan(text: suffix),
        ],
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: true,
    );
  }
}

class RichTextWidget extends StatelessWidget {
  const RichTextWidget({
    super.key,
    required this.text,
    required this.text2,
    this.text3,
    this.text4,
    this.text5,
    this.text6,
    this.fontSize,
    this.fontSize2,
    this.textColor,
    this.textColor2,
    this.textColor3,
    this.fontWeight,
    this.fontWeight2,
    this.fontWeight3,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.decoration2 = TextDecoration.underline,
    this.decoration4 = TextDecoration.underline,
    this.onTap,
    this.onTap1,
    this.fontFamily,
  });

  final String text;
  final String text2;
  final String? text3;
  final String? text4;
  final String? text5;
  final String? text6;
  final double? fontSize;
  final double? fontSize2;
  final Color? textColor;
  final Color? textColor2;
  final Color? textColor3;
  final FontWeight? fontWeight;
  final FontWeight? fontWeight2;
  final FontWeight? fontWeight3;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration2;
  final TextDecoration? decoration4;
  final VoidCallback? onTap;
  final VoidCallback? onTap1;
  final AppFontFamily? fontFamily;

  TextStyle _buildTextStyle({
    required BuildContext context,
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
  }) {
    final AppFontFamily selectedFont = fontFamily ?? .inter;
    final String fontName = switch (selectedFont) {
      .inter => 'Inter',
      .geist => 'Geist',
      .redwing => 'Redwing',
    };
    final bool isAssetFont = selectedFont == .redwing || selectedFont == .geist;
    return isAssetFont
        ? TextStyle(
            fontFamily: fontName,
            fontSize: context.sp(fontSize),
            color: color,
            fontWeight: fontWeight,
          )
        : GoogleFonts.getFont(
            fontName,
            fontSize: context.sp(fontSize),
            color: color,
            fontWeight: fontWeight,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textAlign: textAlign ?? .center,
      maxLines: maxLines,
      TextSpan(
        text: text,
        style: _buildTextStyle(
          context: context,
          fontSize: fontSize ?? 14,
          color: textColor ?? Palette.textBody,
          fontWeight: fontWeight ?? .normal,
        ),
        children: <InlineSpan>[
          TextSpan(
            text: text2,
            recognizer: onTap != null
                ? (TapGestureRecognizer()..onTap = onTap)
                : null,
            style:
                _buildTextStyle(
                  context: context,
                  fontSize: fontSize2 ?? 14,
                  color: textColor2 ?? Palette.linkBlue,
                  fontWeight: fontWeight2 ?? .w600,
                ).copyWith(
                  decoration: decoration2,
                  decorationThickness: 1.5,
                  decorationColor: textColor2 ?? Palette.linkBlue,
                ),
          ),
          if (text3 != null)
            TextSpan(
              text: text3,
              style: _buildTextStyle(
                context: context,
                fontSize: fontSize ?? 14,
                color: textColor3 ?? textColor ?? Palette.textBody,
                fontWeight: fontWeight3 ?? fontWeight ?? .normal,
              ),
            ),
          if (text4 != null)
            TextSpan(
              text: text4,
              recognizer: onTap1 != null
                  ? (TapGestureRecognizer()..onTap = onTap1)
                  : null,
              style: _buildTextStyle(
                context: context,
                fontSize: fontSize ?? 14,
                color: textColor2 ?? Palette.linkBlue,
                fontWeight: fontWeight2 ?? .w600,
              ).copyWith(decorationThickness: 1.5, decoration: decoration4),
            ),
          if (text5 != null)
            TextSpan(
              text: text5,
              recognizer: onTap1 != null
                  ? (TapGestureRecognizer()..onTap = onTap1)
                  : null,
              style: _buildTextStyle(
                context: context,
                fontSize: fontSize ?? 14,
                color: textColor ?? Palette.textBody,
                fontWeight: fontWeight2 ?? .w600,
              ).copyWith(decoration: decoration4),
            ),
          if (text6 != null)
            TextSpan(
              text: text6,
              recognizer: onTap1 != null
                  ? (TapGestureRecognizer()..onTap = onTap1)
                  : null,
              style: _buildTextStyle(
                context: context,
                fontSize: fontSize ?? 14,
                color: textColor2 ?? Palette.linkBlue,
                fontWeight: fontWeight2 ?? .w600,
              ).copyWith(decoration: decoration4),
            ),
        ],
      ),
    );
  }
}
