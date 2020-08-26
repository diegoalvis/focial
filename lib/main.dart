import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/splash/splash_screen.dart';
import 'package:focial/utils/theme.dart';

void main() {
  runApp(FocialApp());
}

class FocialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: 'Focial',
      material: (context, target) => MaterialAppData(
        theme: AppTheme.getTheme(),
      ),
      home: SplashScreen(),
    );
  }
}
