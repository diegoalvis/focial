import 'package:flutter/material.dart';
import 'package:focial/screens/login/login_viewmodel.dart';
import 'package:focial/screens/signup/signup_screen.dart';
import 'package:focial/utils/assets.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/strings.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:focial/widgets/text_fields.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => Scaffold(
        appBar: _appBar(),
        backgroundColor: AppTheme.backgroundColor,
        body: _getBody(model, context),
        bottomNavigationBar: StackInFlow(),
      ),
    );
  }

  Widget _appBar() => AppBar(
        title: Text(
          'Login',
          style: AppTheme.appBarTextStyle,
        ),
      );

  Widget _getBody(LoginViewModel controller, BuildContext context) => SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
              child: Text(
                'Please enter the credentials which you have used during registration',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17.0),
              ),
            ),
            SizedBox(height: 8.0),
            _getForm(controller, context),
            _getButtons(controller, context),
            _getSocialMediaButtons()
          ],
        ),
      );

  Widget _getForm(LoginViewModel controller, BuildContext context) => Card(
        elevation: 8.0,
        margin: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                OutlineBorderedTFWithIcon(
                  label: 'Email',
                  hint: 'john@doe.com',
                  icon: Icons.mail_outline,
                  iconSize: 27.0,
                  validator: controller.validateEmail,
                  save: controller.saveEmail,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlineBorderedTFWithIcon(
                        label: 'Password',
                        hint: '***************',
                        icon: FontAwesomeIcons.unlockAlt,
                        validator: controller.validatePassword,
                        isObscure: !controller.passwordShown,
                        save: controller.savePassword,
                      ),
                    ),
                    IconButton(
                      icon: Icon(controller.passwordShown
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => controller.togglePasswordVisibility(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget _getButtons(LoginViewModel controller, BuildContext context) => Column(
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
              onPressed: () => controller.validateAndLogin(context),
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

  Widget _getSocialMediaButtons() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SocialMediaButton(
          onPressed: () {},
          asset: Assets.GOOGLE_LOGO,
          text: Strings.LOGIN_WITH_GOOGLE,
        ),
        SizedBox(height: 8.0),
        SocialMediaButton(
          onPressed: () {},
          asset: Assets.FACEBOOK_LOGO,
          text: Strings.LOGIN_WITH_FACEBOOK,
        ),
      ],
    );
  }
}
