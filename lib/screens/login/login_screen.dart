import 'package:flutter/material.dart';
import 'package:focial/screens/signup/signup_screen.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:focial/widgets/text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: AppTheme.backgroundColor,
      body: _getBody(),
      bottomNavigationBar: StackInFlow(),
    );
  }

  Widget _appBar() => AppBar(
        title: Text(
          'Login',
          style: AppTheme.appBarTextStyle,
        ),
      );

  Widget _getBody() => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Text(
                'Please enter the credentials which you have used during registration',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 8.0),
            _getForm(),
            _getButtons()
          ],
        ),
      );

  Widget _getForm() => Card(
        elevation: 8.0,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            child: Column(
              children: [
                OutlineBorderedTFWithIcon(
                  label: 'Email',
                  icon: Icons.mail_outline,
                  iconSize: 24.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                OutlineBorderedTFWithIcon(
                  label: 'Password',
                  icon: FontAwesomeIcons.unlockAlt,
                )
              ],
            ),
          ),
        ),
      );

  Widget _getButtons() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              padding: const EdgeInsets.only(left: 6.0, right: 16.0),
              onPressed: () {},
              child: Text(
                'Forgot password?',
                style: AppTheme.flatButtonTheme,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: AppPlatformButtonWithArrow(
              onPressed: () {},
              text: 'LOGIN',
            ),
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'New to Focial?',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              FlatButton(
                padding: const EdgeInsets.only(left: 6.0),
                onPressed: () {
                  Navigator.of(context)
                      .push(AppNavigation.route(SignUpScreen()));
                },
                child: Text(
                  'Create an account',
                  style: AppTheme.flatButtonTheme,
                ),
              )
            ],
          )
        ],
      );
}
