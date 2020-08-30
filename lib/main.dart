import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/splash/splash_screen.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/loader.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:ots/ots.dart';

void main() {
  setupLogging();
  setupServices();
  runApp(FocialApp());
}

void setupServices() {
  GetIt.I.registerSingleton<AuthService>(AuthService());
  GetIt.I.registerSingleton<UserData>(UserData());
}

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class FocialApp extends StatefulWidget {
  @override
  _FocialAppState createState() => _FocialAppState();
}

class _FocialAppState extends State<FocialApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OTS(
      persistNoInternetNotification: false,
      showNetworkUpdates: false,
      loader: const Loader(size: 100.0),
      child: MultiBlocProvider(
        providers: [BlocProvider(create: (_) => UserData())],
        child: PlatformApp(
          title: 'Focial',
          material: (context, target) => MaterialAppData(
            theme: AppTheme.getTheme(),
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
