import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/login/login_controller.dart';
import 'package:focial/screens/splash/splash_screen.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/loader.dart';
import 'package:ots/ots.dart';

void main() {
  runApp(FocialApp());
}

class FocialApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OTS(
      persistNoInternetNotification: false,
      showNetworkUpdates: false,
      loader: const Loader(size: 100.0),
      child: PlatformApp(
        title: 'Focial',
        material: (context, target) => MaterialAppData(
          theme: AppTheme.getTheme(),
        ),
        home: BlocProvider(
          create: (_) => LoginBloc(),
          child: SplashScreen(),
        ),
      ),
    );
  }
}
