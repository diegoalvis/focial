import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/login/login_viewmodel.dart';
import 'package:focial/screens/profile/edit_profile_viewmodel.dart';
import 'package:focial/screens/signup/signup_viewmodel.dart';
import 'package:focial/screens/splash/splash_screen.dart';
import 'package:focial/screens/stories/new_story_viewmodel.dart';
import 'package:focial/screens/tabs_screen/tabs_viewmodel.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/app_data.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/post_feed.dart';
import 'package:focial/services/story.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/loader.dart';
import 'package:logging/logging.dart';
import 'package:ots/ots.dart';
import 'package:provider/provider.dart';

void main() {
  setupLogging();
  setupServices();
  runApp(FocialApp());
}

void setupServices() {
  find.registerSingleton<APIService>(APIService());
  find.registerSingleton<AuthService>(AuthService());
  find.registerSingleton<UserData>(UserData());
  find.registerSingleton<StoryService>(StoryService());
  find.registerSingleton<PostFeedService>(PostFeedService());
  find.registerSingleton<AppDataService>(AppDataService());
}

void disposeServices() {
  find<AuthService>().dispose();
}

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

class FocialApp extends StatelessWidget {
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
}
