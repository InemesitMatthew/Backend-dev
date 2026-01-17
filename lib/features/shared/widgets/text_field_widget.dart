import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.suffix,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.prefixIcon,
    this.maxLine,
    this.isPassword = false,
    this.showPasswordToggle = true,
    this.fillColor = Palette.fillColor,
    this.inputFormatters,
    this.hintColor,
    this.hintFontSize,
    this.hintLetterSpacing,
    this.hintLineHeight,
    this.validator,
    this.controller,
    this.title,
    this.onTap,
    this.autofillHints,
    this.onChanged,
    this.isReadOnly = false,
    this.contentPadding,
    this.textFontSize,
    this.textFontWeight = .w400,
    this.hasActiveState = true,
    this.error,
    this.onFieldSubmitted,
    this.textCapitalization = .none,
    this.focusNode,
    this.autovalidateMode = .onUserInteraction,
    this.validateOnFocusLost = false,
    this.borderRadius,
    this.borderWidth = 0.75,
    this.fontFamily,
    this.floatingLabelBehavior,
    this.floatingLabelFontSize,
    this.isLabelInside = false,
    this.fieldHeight,
    this.focusedBorderColor,
    this.focusedBorderWidth,
    this.reserveErrorSpace = false,
  });

  final String? hintText;
  final String? labelText;
  final String? initialValue;
  final Widget? suffix;
  final bool isPassword;
  final bool showPasswordToggle;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final int? maxLine;
  final Color? fillColor;
  final Color? hintColor;
  final double? hintFontSize;
  final double? hintLetterSpacing;
  final double? hintLineHeight;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? title;
  final bool hasActiveState;
  final bool isReadOnly;
  final EdgeInsets? contentPadding;
  final double? textFontSize;
  final FontWeight textFontWeight;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;
  final Iterable<String>? autofillHints;
  final String? error;
  final void Function(String)? onFieldSubmitted;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final AutovalidateMode autovalidateMode;
  final bool validateOnFocusLost;
  final double? borderRadius;
  final double borderWidth;
  final AppFontFamily? fontFamily;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final double? floatingLabelFontSize;
  final bool isLabelInside;
  final double? fieldHeight;
  final Color? focusedBorderColor;
  final double? focusedBorderWidth;
  final bool reserveErrorSpace;

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final ValueNotifier<bool> obscureText = ValueNotifier<bool>(true);
  final GlobalKey<FormFieldState<String>> _fieldKey =
      GlobalKey<FormFieldState<String>>();
  bool _wasFocused = false;
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureText,
      builder: (_, value, _) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              if (widget.title != null) ...[
                TextWidget(widget.title!),
                context.verticalSpace(8),
              ],
              Focus(
                onFocusChange: (hasFocus) {
                  _hasFocus = hasFocus;
                  if (hasFocus) {
                    _wasFocused = true;
                  } else {
                    if (_wasFocused && widget.validateOnFocusLost) {
                      _fieldKey.currentState?.validate();
                    }
                  }
                },
                child: Localizations.override(
                  context: context,
                  delegates: const [
                    DefaultMaterialLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                    DefaultWidgetsLocalizations.delegate,
                  ],
                  child: Material(
                    type: MaterialType.transparency,
                    child: SizedBox(
                      height: widget.fieldHeight,
                      child: TextFormField(
                      key: _fieldKey,
                      onTap: widget.onTap,
                      textCapitalization: widget.textCapitalization,
                      focusNode: widget.focusNode,
                      autofillHints: widget.autofillHints,
                      initialValue: widget.initialValue,
                      readOnly: widget.isReadOnly,
                      controller: widget.controller,
                      maxLines: widget.maxLine ?? 1,
                      cursorColor: Palette.basePrimary,
                      textInputAction: widget.textInputAction,
                      keyboardType: widget.keyboardType,
                      obscureText: value && widget.isPassword,
                      onChanged: (val) {
                        widget.onChanged?.call(val);
                        if (widget.validateOnFocusLost && _wasFocused) {
                          if (val.trim().isEmpty) {
                            _fieldKey.currentState?.validate();
                          } else {
                            _fieldKey.currentState?.validate();
                          }
                        }
                      },
                      style: _buildTextStyle(
                        context: context,
                        fontSize: widget.textFontSize ?? context.sp(16),
                        color: Palette.text100,
                        fontWeight: widget.textFontWeight,
                      ),
                      autovalidateMode: widget.autovalidateMode,
                      inputFormatters: widget.inputFormatters,
                      validator: (val) {
                        final validator = widget.validator;
                        if (validator == null) return null;
                        if (widget.validateOnFocusLost) {
                          if (val == null || val.trim().isEmpty) {
                            return 'This field is required';
                          }
                          if (_hasFocus) {
                            return null;
                          }
                        }
                        return validator(val);
                      },
                      autocorrect: false,
                      onFieldSubmitted: widget.onFieldSubmitted,
                      onTapOutside: (_) => FocusScope.of(context).unfocus(),
                      decoration: InputDecoration(
                        prefixIcon: widget.prefixIcon,
                        fillColor: widget.fillColor,
                        isDense: true,
                        filled: widget.fillColor != null,
                        hintText: widget.hintText,
                        hintStyle: _buildTextStyle(
                          context: context,
                          fontSize: context.sp(widget.hintFontSize ?? 14),
                          color: widget.hintColor ?? Palette.text300,
                          fontWeight: .w400,
                          letterSpacing: widget.hintLetterSpacing,
                          height: widget.hintLineHeight,
                        ),
                        labelText: widget.labelText,
                        labelStyle: _buildTextStyle(
                          context: context,
                          fontSize: context.sp(widget.hintFontSize ?? 14),
                          color: widget.hintColor ?? Palette.text300,
                          fontWeight: .w400,
                          letterSpacing: widget.hintLetterSpacing,
                          height: widget.hintLineHeight,
                        ),
                        floatingLabelStyle: _buildTextStyle(
                          context: context,
                          fontSize: context.sp(
                            widget.floatingLabelFontSize ??
                                (widget.hintFontSize ?? 14) - 2,
                          ),
                          color: widget.hintColor ?? Palette.text300,
                          fontWeight: .w400,
                          letterSpacing: widget.hintLetterSpacing,
                          height: widget.hintLineHeight,
                        ),
                        floatingLabelBehavior:
                            widget.floatingLabelBehavior ??
                            FloatingLabelBehavior.auto,
                        alignLabelWithHint: widget.isLabelInside,
                        suffixIcon: widget.isPassword == true
                            ? (widget.showPasswordToggle
                                  ? _suffixWidget(value)
                                  : widget.suffix)
                            : widget.suffix,
                        contentPadding:
                            widget.contentPadding ??
                            (widget.isLabelInside
                                ? const EdgeInsets.all(12)
                                : (widget.suffix != null ||
                                          widget.prefixIcon != null
                                      ? context.all(12)
                                      : context.all(15))),
                        border: _border,
                        errorBorder: _errorBorder,
                        errorMaxLines: 1,
                        errorStyle: widget.reserveErrorSpace
                            ? const TextStyle(
                                fontSize: 0.1,
                                height: 0.01,
                                color: Colors.transparent,
                              )
                            : _buildTextStyle(
                                context: context,
                                fontSize: context.sp(12),
                                color: Palette.baseError,
                                fontWeight: .w400,
                              ),
                        disabledBorder: _border,
                        enabledBorder: _border,
                        focusedBorder: _focusedBorder,
                        focusedErrorBorder: _errorBorder,
                      ),
                    ),
                  ),
                  ),
                ),
              ),
              if (widget.error != null) ...[
                TextWidget(
                  widget.error!,
                  fontSize: 11,
                  fontWeight: .w400,
                  textColor: Palette.baseError,
                ),
              ] else if (widget.reserveErrorSpace) ...[
                context.verticalSpace(2),
                SizedBox(
                  height: context.h(12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TextWidget(
                      _fieldKey.currentState?.errorText ?? '',
                      fontSize: 11,
                      fontWeight: .w400,
                      textColor: Palette.baseError,
                    ),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: .circular(widget.borderRadius ?? context.w(8)),
      borderSide: BorderSide(
        color: widget.error != null ? Palette.baseError : Palette.border,
        width: widget.borderWidth,
      ),
    );
  }

  OutlineInputBorder get _focusedBorder {
    return OutlineInputBorder(
      borderRadius: .circular(widget.borderRadius ?? context.w(8)),
      borderSide: BorderSide(
        color: widget.focusedBorderColor ?? Palette.border,
        width: widget.focusedBorderWidth ?? widget.borderWidth,
      ),
    );
  }

  OutlineInputBorder get _errorBorder {
    return OutlineInputBorder(
      borderRadius: .circular(widget.borderRadius ?? context.w(8)),
      borderSide: const BorderSide(color: Palette.baseError, width: 1),
    );
  }

  TextStyle _buildTextStyle({
    required BuildContext context,
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
    double? height,
    double? letterSpacing,
  }) {
    final AppFontFamily selectedFont = widget.fontFamily ?? .inter;
    final String fontName = switch (selectedFont) {
      .inter => 'Inter',
      .geist => 'Geist',
      .redwing => 'Redwing',
    };
    return selectedFont == .redwing
        ? TextStyle(
            fontFamily: fontName,
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            height: height,
            letterSpacing: letterSpacing,
          )
        : GoogleFonts.getFont(
            fontName,
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            height: height,
            letterSpacing: letterSpacing,
          );
  }

  Widget _suffixWidget(bool value) {
    return GestureDetector(
      onTap: () => obscureText.value = !obscureText.value,
      child: Icon(
        value ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
        color: Palette.text300,
        size: 18,
      ),
    );
  }
}
