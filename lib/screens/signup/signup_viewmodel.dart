import 'package:flutter/cupertino.dart';
import 'package:focial/screens/login/login_screen.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/server_responses.dart';
import 'package:focial/utils/validators.dart';
import 'package:get_it/get_it.dart';
import 'package:ots/ots.dart';

class SignUpViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  final authService = GetIt.I<AuthService>();
  final formKey = GlobalKey<FormState>();
  String name, email, password;
  bool _passwordShown = false;

  Future<void> validateAndRegister(BuildContext context) async {
    if (!formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader();
    formKey.currentState.save();
    debugPrint(
        "register fields are correct, name: $name, email: $email, password: $password");
    register();
  }

  Future<void> register() async {
    final response = await authService.register(
        email: email, password: password, name: name);
    if (response.isSuccessful) {
      AppOverlays.showSuccess(
          "Server response", ServerResponse.getMessage(response));
      formKey.currentState.reset();
      Navigator.of(_context)
          .pushReplacement(AppNavigation.route(LoginScreen()));
    } else {
      AppOverlays.showError(
          "Server response", ServerResponse.getMessage(response));
    }
    hideLoader();
  }

  String validateEmail(String value) => FormValidators().validateEmail(value);

  String validatePassword(String value) =>
      FormValidators().validatePassword(value);

  void saveName(String value) {
    name = value;
  }

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
