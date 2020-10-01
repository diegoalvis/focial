import 'package:flutter/cupertino.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/server_responses.dart';
import 'package:focial/utils/validators.dart';
import 'package:ots/ots.dart';

enum ForgotPasswordStage { SendResetCode, ResetPassword }

class ForgotPasswordViewModel extends ChangeNotifier {
  BuildContext _context;
  ForgotPasswordStage _stage = ForgotPasswordStage.SendResetCode;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String _emailError, _otpError, _passwordError;
  bool _showPassword = false;
  bool _activateResendOTPLink = false;

  void init(BuildContext context) {
    _context = context;
  }

  Future<void> sendResetCode() async {
    emailError = FormValidators().validateEmail(emailController.text);
    if (emailError != null) {
      return;
    }
    FocusScope.of(_context).requestFocus(FocusNode());
    showLoader();
    final response = await find<APIService>()
        .api
        .sendPasswordResetCode(email: emailController.text);
    if (response.isSuccessful) {
      stage = ForgotPasswordStage.ResetPassword;
      _startActivationOfResendOTP();
    } else {
      AppOverlays.showError(
          "Server response", ServerResponse.getMessage(response));
    }
    hideLoader();
  }

  void resendOTP() async {
    activateResendOTPLink = false;
    showLoader();
    final response = await find<APIService>()
        .api
        .resendPasswordResetCode(email: emailController.text);
    if (response.isSuccessful) {
      _startActivationOfResendOTP();
    } else {
      AppOverlays.showError(
          "Server response", ServerResponse.getMessage(response));
    }
    hideLoader();
  }

  _startActivationOfResendOTP() {
    Future.delayed(Duration(minutes: 1)).whenComplete(() {
      activateResendOTPLink = true;
    });
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
  }

  Future<void> resetPassword() async {
    print("resetting password");
    if (otpController.text.length != 6) {
      otpError = "Enter a valid OTP";
    }
    passwordError = FormValidators().validatePassword(passwordController.text);
    if (passwordError != null) {
      return;
    }
    otpError = null;

    FocusScope.of(_context).requestFocus(FocusNode());
    showLoader();
    final response = await find<APIService>().api.resetPassword(
          email: emailController.text,
          otp: otpController.text,
          password: passwordController.text,
        );
    hideLoader();
    if (response.isSuccessful) {
      AppOverlays.showSuccess("Success", ServerResponse.getMessage(response));
      Navigator.of(_context).pop();
    } else {
      AppOverlays.showError("Failed", ServerResponse.getMessage(response));
    }
  }

  ForgotPasswordStage get stage => _stage;

  set stage(ForgotPasswordStage value) {
    _stage = value;
    notifyListeners();
  }

  String get emailError => _emailError;

  set emailError(String value) {
    _emailError = value;
    notifyListeners();
  }

  bool get showPassword => _showPassword;

  set showPassword(bool value) {
    _showPassword = value;
    notifyListeners();
  }

  get passwordError => _passwordError;

  set passwordError(value) {
    _passwordError = value;
    notifyListeners();
  }

  get otpError => _otpError;

  set otpError(value) {
    _otpError = value;
    notifyListeners();
  }

  bool get activateResendOTPLink => _activateResendOTPLink;

  set activateResendOTPLink(bool value) {
    _activateResendOTPLink = value;
    notifyListeners();
  }
}
