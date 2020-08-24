import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/text_fields.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _isInitialized = false;

  StreamController<bool> streamController = StreamController();

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    initApp();
    super.initState();
  }

  Future<void> initApp() async {
    if (!_isInitialized) {
      _animationController = AnimationController(
          vsync: this, duration: Duration(milliseconds: 200));
      _animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(
          curve: Curves.linear,
          parent: _animationController,
        ),
      );
      _isInitialized = true;
      await Future.delayed(Duration(milliseconds: 800));
      bool _loggedIn = false;
      if (_loggedIn)
        loggedIn();
      else
        notLoggedIn();
    }
  }

  void loggedIn() {
    print("loggedIn");
  }

  void notLoggedIn() {
    print("not loggedIn");
//    _animationController.addListener(animListener);
    _animationController.forward();
  }

//  void animListener() {
//    print(_animation.value);
//  }

  double logoPosition = -128.0;

  void addEvent(bool event) {
    streamController.sink.add(event);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) => Stack(
          children: [
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: (size.height / 2) - logoPosition * _animation.value,
              child: Image.asset(
                Assets.LOGO_TRANSPARENT,
                height: 256.0,
                width: 256.0,
              ),
            ),
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom:
                  MediaQuery.of(context).size.height * .4 * _animation.value,
              child: LoginForm(event: addEvent),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    streamController.sink.close();
    streamController.close();
    super.dispose();
  }
}

class LoginForm extends StatefulWidget {
  final Function(bool) event;

  const LoginForm({Key key, this.event}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  double cardHeight = 390.0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.all(0.0),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.00),
          topRight: Radius.circular(36.00),
        ),
      ),
      child: SizedBox(
        height: cardHeight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(double.infinity, 00.0),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * .25, right: size.width * .25),
                  child: TabBar(
                    labelStyle: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                    indicatorColor: AppTheme.primaryColor,
                    labelColor: AppTheme.primaryColor,
                    unselectedLabelColor:
                        AppTheme.primaryColor.withOpacity(0.5),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: [
                      Tab(
                        text: 'Login',
                      ),
                      Tab(
                        text: 'SignUp',
                      ),
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [loginForm(), signUpForm()],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget loginForm() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: []
            ..addAll(loginFields())
            ..add(FlatButton(onPressed: () {}, child: Text('Forgot password?')))
            ..add(SizedBox(height: 16.0))
            ..addAll(_buttons()),
        ),
      ),
    );
  }

  Widget signUpForm() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12.0),
            OutlinedTextField(
              label: 'Full name',
              hint: 'John doe',
            ),
          ]
            ..addAll(loginFields())
            ..add(SizedBox(height: 16.0))
            ..addAll(_buttons()),
        ),
      ),
    );
  }

  List<Widget> loginFields() => [
        SizedBox(height: 12.0),
        OutlinedTextField(
          label: 'Email',
          hint: 'john@doe.com',
        ),
        SizedBox(height: 12.0),
        OutlinedTextField(
          label: 'Password',
          hint: '**********',
          isObscure: true,
          suffix: InkWell(child: Icon(Icons.remove_red_eye)),
        ),
      ];

  List<Widget> _buttons() => [
        AppPlatformButton(
          height: 50.0,
          width: double.infinity,
          text: 'SUBMIT',
          onPressed: () {},
          borderRadius: 8.0,
          elevation: 4.0,
          color: AppTheme.primaryColor,
        ),
        SizedBox(height: 8.0),
        _getSocialButtons(),
      ];

  Widget _getSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Spacer(flex: 1),
        SocialButton(
          asset: Assets.GOOGLE_LOGO,
        ),
        SizedBox(width: 8.0),
        SocialButton(
          asset: Assets.FACEBOOK_LOGO,
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
