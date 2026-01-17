import 'package:backend_dev/core/core.dart';

class AppTheme {
  const AppTheme();
  static const CupertinoThemeData cupertinoTheme = CupertinoThemeData(
    brightness: .light,
    primaryColor: Palette.primary,
    barBackgroundColor: Palette.background,
    scaffoldBackgroundColor: Palette.background,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(
        color: Palette.textPrimary,
        fontSize: 14,
        fontWeight: .w400,
      ),
    ),
  );
}
