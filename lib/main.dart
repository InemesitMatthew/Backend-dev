import 'package:backend_dev/core/core.dart';
import 'package:backend_dev/features/features.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      title: 'Backend Dev',
      theme: AppTheme.cupertinoTheme,
      home: ApartmentDetailsScreen(),
    );
  }
}
