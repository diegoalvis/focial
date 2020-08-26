import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/services/api.dart';
import 'package:focial/utils/validators.dart';
import 'package:ots/ots.dart';

enum SignupEvent { TogglePasswordVisibility, SubmitFields }

class SignupState {
  bool passwordShown;

  SignupState({this.passwordShown = true});

  SignupState copyWith({bool passwordShown}) {
    return SignupState(passwordShown: passwordShown);
  }
}

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final formKey = GlobalKey<FormState>();
  String name, email, password;

  SignupBloc() : super(SignupState());

  Future<void> validateLoginForm(BuildContext context) async {
    if (!formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader();
    formKey.currentState.save();
    debugPrint(
        "register fields are correct, name: $name, email: $email, password: $password");
    register();
  }

  Future<void> register() async {
    final response = await APIService.api.register(
      email: email,
      name: name,
      password: password,
    );
    print(response.body);
    print(response.error);
    print(response.statusCode);
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

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    switch (event) {
      case SignupEvent.TogglePasswordVisibility:
        yield togglePasswordVisibility();
        break;
      case SignupEvent.SubmitFields:
        // TODO: Handle this case.
        break;
    }
  }

  SignupState togglePasswordVisibility() {
    return state.copyWith(passwordShown: !state.passwordShown);
  }
}
