import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focial/screens/login/login_screen.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/stackinflow.dart';

// ignore: must_be_immutable
class SplashScreen extends StatelessWidget {
  bool _isInitialized = false;

  Future<void> initApp(BuildContext context) async {
    if (!_isInitialized) {
      _isInitialized = true;
      await Future.delayed(Duration(milliseconds: 800));
      bool _loggedIn = false;
      if (_loggedIn)
        loggedIn(context);
      else
        notLoggedIn(context);
    }
  }

  void loggedIn(BuildContext context) {
    print("loggedIn");
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
