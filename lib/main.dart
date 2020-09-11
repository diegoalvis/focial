import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/login/login_viewmodel.dart';
import 'package:focial/screens/profile/edit_profile_viewmodel.dart';
import 'package:focial/screens/signup/signup_viewmodel.dart';
import 'package:focial/screens/splash/splash_screen.dart';
import 'package:focial/screens/stories/new_story_viewmodel.dart';
import 'package:focial/screens/tabs_screen/tabs_viewmodel.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/story.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/loader.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

void main() {
  setupLogging();
  setupServices();
  runApp(FocialApp());
}

void setupServices() {
  GetIt.I.registerSingleton<APIService>(APIService());
  GetIt.I.registerSingleton<AuthService>(AuthService());
  GetIt.I.registerSingleton<UserData>(UserData());
  GetIt.I.registerSingleton<StoryService>(StoryService());
}

void disposeServices() {
  GetIt.I<AuthService>().dispose();
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserData(),
        ),
        ChangeNotifierProvider(
          create: (_) => StoryService(),
        ),
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => TabsViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (_) => EditProfileViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewStoryViewmodel(),
        ),
      ],
      child: OTS(
        persistNoInternetNotification: false,
        showNetworkUpdates: false,
        loader: const Loader(size: 100.0),
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
