import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focial/screens/tabs_screen/tabs_screen.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/server_responses.dart';
import 'package:focial/utils/validators.dart';
import 'package:ots/ots.dart';

class LoginViewModel extends ChangeNotifier {
  final authService = find<AuthService>();
  final formKey = GlobalKey<FormState>();
  String email, password;
  bool _passwordShown = false;

  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  Future<void> validateAndLogin(BuildContext context) async {
    if (!formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader();
    formKey.currentState.save();
    debugPrint("Login fields are correct, email: $email, password: $password");
    login(context);
  }

  Future<void> login(BuildContext context) async {
    final response = await authService.login(email: email, password: password);
    if (response.isSuccessful) {
      // AppOverlays.showSuccess("Server response", "Login Successful");
      find<UserData>()..fetchUser();
      Navigator.of(context).push(AppNavigation.route(TabsScreen()));
    } else {
      AppOverlays.showError(
          "Server response", ServerResponse.getMessage(response));
    }
    hideLoader();
  }

  String validateEmail(String value) => FormValidators().validateEmail(value);

  String validatePassword(String value) =>
      FormValidators().validatePassword(value);

  void saveEmail(String value) {
    email = value;
  }

  void savePassword(String value) {
    password = value;
  }

  togglePasswordVisibility() {
    passwordShown = !passwordShown;
  }

  bool get passwordShown => _passwordShown;

  set passwordShown(bool value) {
    _passwordShown = value;
    notifyListeners();
  }
}
