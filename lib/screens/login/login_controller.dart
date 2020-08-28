import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focial/services/auth.dart';
import 'package:focial/utils/overlays.dart';
import 'package:focial/utils/server_responses.dart';
import 'package:focial/utils/validators.dart';
import 'package:get_it/get_it.dart';
import 'package:ots/ots.dart';

enum LoginEvent { TogglePasswordVisibility }

class LoginState {
  bool passwordShown;

  LoginState({this.passwordShown = true});

  LoginState copyWith({bool passwordShown}) {
    return LoginState(passwordShown: passwordShown);
  }
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final authService = GetIt.I<AuthService>();
  final formKey = GlobalKey<FormState>();
  String email, password;

  LoginBloc() : super(LoginState());

  Future<void> validateLoginForm(BuildContext context) async {
    if (!formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader();
    formKey.currentState.save();
    debugPrint("Login fields are correct, email: $email, password: $password");
    login();
  }

  Future<void> login() async {
    final response = await authService.login(email: email, password: password);
    if (response.isSuccessful) {
      AppOverlays.showSuccess("Server response", "Login Successful");
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

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    switch (event) {
      case LoginEvent.TogglePasswordVisibility:
        yield togglePasswordVisibility();
        break;
      // case LoginEvent.SubmitFields:
      //   break;
    }
  }

  LoginState togglePasswordVisibility() {
    return state.copyWith(passwordShown: !state.passwordShown);
  }
}
