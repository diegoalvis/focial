import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focial/screens/login/login_screen.dart';
import 'package:focial/screens/tabs_screen/tabs_screen.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  bool _isInitialized = false;

  Future<void> initApp(BuildContext context) async {
    if (!_isInitialized) {
      _isInitialized = true;

      final authService = GetIt.I<AuthService>();
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
    Navigator.of(context).push(AppNavigation.route(TabsScreen()));
  }

  void notLoggedIn(BuildContext context) {
    print("not loggedIn");
    Navigator.of(context).push(AppNavigation.route(LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    initApp(context);
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Center(
        child: Image.asset(
          Assets.LOGO_TRANSPARENT,
          height: 256.0,
          width: 256.0,
        ),
      ),
      bottomNavigationBar: StackInFlow(),
    );
  }
}
