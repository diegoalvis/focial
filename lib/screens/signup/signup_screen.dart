import 'package:flutter/material.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:focial/widgets/text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
          'Signup',
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
                'Welcome to Focial\nRegister and get started, we never share our user\'s  data',
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
                  label: 'Full name',
                  hint: 'John Doe',
                  icon: FontAwesomeIcons.user,
                ),
                SizedBox(
                  height: 8.0,
                ),
                OutlineBorderedTFWithIcon(
                  label: 'Email',
                  hint: 'john@doe.com',
                  icon: Icons.mail_outline,
                  iconSize: 24.0,
                ),
                SizedBox(
                  height: 8.0,
                ),
                OutlineBorderedTFWithIcon(
                  label: 'Password',
                  hint: '***************',
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
          SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: AppPlatformButtonWithArrow(
              onPressed: () {},
              text: 'SIGNUP',
            ),
          ),
          SizedBox(height: 16.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'By creating an account, you agree to our',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 6.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Terms of service  ',
                      style: AppTheme.flatButtonTheme,
                    ),
                  ),
                  Text(
                    'and',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      '  Privacy policy',
                      style: AppTheme.flatButtonTheme,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      );
}
