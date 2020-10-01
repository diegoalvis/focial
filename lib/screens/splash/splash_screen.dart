import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focial/screens/splash/splash_viewmodel.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:stacked/stacked.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => SplashViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => Scaffold(
        backgroundColor: AppTheme.primaryColor,
        body: Center(
          child: Image.asset(
            Assets.LOGO_TRANSPARENT,
            height: 256.0,
            width: 256.0,
          ),
        ),
        bottomNavigationBar: StackInFlow(),
      ),
    );
  }
}
