import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/screens/forgot_password/forgot_password_viewmodel.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/text_fields.dart';
import 'package:stacked/stacked.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgotPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgotPasswordViewModel(),
      onModelReady: (m) => m.init(context),
      builder: (context, model, child) => PlatformScaffold(
        appBar: PlatformAppBar(
          material: (context, data) => MaterialAppBarData(
            elevation: 0.0,
            centerTitle: true,
          ),
          title: Text(
            "Forgot password",
            style: AppTheme.appBarTextStyle,
          ),
        ),
        body: model.stage == ForgotPasswordStage.SendResetCode
            ? _sendResetCodeBody(model)
            : _resetPasswordBody(model),
      ),
    );
  }

  Widget _sendResetCodeBody(ForgotPasswordViewModel model) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Text(
            'Please enter your email to receive a password reset code',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Card(
          elevation: 8.0,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: TFWithIcon(
              controller: model.emailController,
              label: 'Email',
              hint: 'john@doe.com',
              icon: Icons.mail_outline,
              iconSize: 24.0,
              error: model.emailError,
              // validator: controller.validateEmail,
              // save: controller.saveEmail,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: AppPlatformButtonWithArrow(
            onPressed: model.sendResetCode,
            text: 'GET CODE',
          ),
        ),
      ],
    );
  }

  Widget _resetPasswordBody(ForgotPasswordViewModel model) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
          child: Text(
            'Please enter the OTP and new password',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16.0),
          ),
        ),
        Card(
          elevation: 8.0,
          margin: const EdgeInsets.all(8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                TFWithIcon(
                  controller: model.otpController,
                  label: 'One time password',
                  hint: '123456',
                  icon: Icons.phonelink_lock,
                  iconSize: 24.0,
                  error: model.otpError,
                  textInputType: TextInputType.number,
                  // validator: controller.validateEmail,
                  // save: controller.saveEmail,
                ),
                TFWithIcon(
                  controller: model.passwordController,
                  label: 'New password',
                  hint: '*******',
                  isObscure: !model.showPassword,
                  icon: Icons.lock_open,
                  iconSize: 24.0,
                  error: model.passwordError,
                  suffixIcon: IconButton(
                    icon: Icon(model.showPassword
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: model.togglePasswordVisibility,
                  ),
                  // validator: controller.validateEmail,
                  // save: controller.saveEmail,
                ),
              ],
            ),
          ),
        ),
        if (model.activateResendOTPLink)
          FlatButton(
            padding: const EdgeInsets.only(left: 6.0),
            onPressed: model.resendOTP,
            child: Text(
              'Didn\'t receive OTP? Click here to resend',
              style: AppTheme.flatButtonTheme,
            ),
          ),
        SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          child: AppPlatformButtonWithArrow(
            onPressed: model.resetPassword,
            text: 'RESET PASSWORD',
          ),
        ),
      ],
    );
  }
}
