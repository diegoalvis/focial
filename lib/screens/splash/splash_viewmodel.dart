import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:focial/screens/login/login_screen.dart';
import 'package:focial/screens/tabs_screen/tabs_screen.dart';
import 'package:focial/services/app_data.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/utils/navigation.dart';

class SplashViewModel extends ChangeNotifier {
  bool _isInitialized = false;

  Future<void> init(BuildContext context) async {
    if (!_isInitialized) {
      _isInitialized = true;

      final authService = find<AuthService>();
      await authService.init();
      // print(authService.authData);
      if (authService.authData.isLoggedIn)
        loggedIn(context);
      else
        notLoggedIn(context);
    }
  }

  void loggedIn(BuildContext context) {
    print("loggedIn");
    // fetch userData in background
    find<AppDataService>().onAppOpen();
    Navigator.of(context).push(AppNavigation.route(TabsScreen()));
  }

  void notLoggedIn(BuildContext context) {
    print("not loggedIn");
    Navigator.of(context).push(AppNavigation.route(LoginScreen()));
  }
}
