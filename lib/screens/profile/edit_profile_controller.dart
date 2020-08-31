import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/user.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/overlays.dart';
import 'package:get_it/get_it.dart';
import 'package:ots/ots.dart';

/*
-------------------------------------------------------------------------------
--------------------------------------Events-----------------------------------
-------------------------------------------------------------------------------
 */
final usernameRegex = RegExp('^[a-z][a-z0-9_]{3,10}');
final phoneRegex =
    RegExp('^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}');

abstract class EditProfileEvent {}

class ValidateForm extends EditProfileEvent {
  BuildContext context;

  ValidateForm(this.context);
}

class CheckUsername extends EditProfileEvent {
  String username;

  CheckUsername(this.username);
}

class UpdateUser extends EditProfileEvent {
  User user;

  UpdateUser(this.user);
}

/*
-------------------------------------------------------------------------------
--------------------------------------State------------------------------------
-------------------------------------------------------------------------------
 */
class EditProfileState {
  User currentUser;
  Status status;
  String usernameMessage;
  bool usernameAvailable;
  bool usernameChecked;
  bool usernameError;

  EditProfileState(
      {this.currentUser,
      this.status = Status.Idle,
      this.usernameAvailable = true,
      this.usernameChecked = false,
      this.usernameError = false,
      this.usernameMessage});

  EditProfileState copyWith(
      {User currentUser,
      Status status,
      String usernameMessage,
      bool usernameAvailable,
      bool usernameChecked,
      bool usernameError}) {
    return EditProfileState(
        usernameError: usernameError ?? this.usernameError,
        currentUser: currentUser ?? this.currentUser,
        status: status ?? this.status,
        usernameAvailable: usernameAvailable ?? this.usernameAvailable,
        usernameChecked: usernameChecked ?? this.usernameChecked,
        usernameMessage: usernameMessage ?? this.usernameMessage);
  }
}

/*
-------------------------------------------------------------------------------
--------------------------------------Bloc-------------------------------------
-------------------------------------------------------------------------------
 */
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileState());

  final formKey = GlobalKey<FormState>();

  void updateUserProfile(BuildContext context) async {
    showLoader(isModal: true);
    final response =
        await GetIt.I<UserData>().updateUserProfile(state.currentUser);
    hideLoader();
    if (response.isSuccessful) {
      Navigator.of(context).pop();
    } else {
      AppOverlays.showError(
          "Server response", "Unable to update profile, please try later");
    }
  }

  void validateForm(BuildContext context) {
    if (!formKey.currentState.validate()) return;
    FocusScope.of(context).requestFocus(FocusNode());
    formKey.currentState.save();
    updateUserProfile(context);
  }

  String usernameValidation(String username) {
    if (username.length > 10 || username.length < 3)
      return "Username length is min 3 and max 10";
    if (usernameRegex.hasMatch(username)) return null;
    return "Invalid username";
  }

  String validateAge(String age) {
    if (age == null) return "Invalid age";
    try {
      int a = int.parse(age);
      if (a > 99 || a < 6) return "Invalid age";
      return null;
    } catch (err) {
      return "Invalid age";
    }
  }

  String validatePhone(String phone) {
    if (phone == null || phone.length == 0) return null;
    if (phoneRegex.hasMatch(phone)) return null;
    return "Invalid phone";
  }

  @override
  Stream<EditProfileState> mapEventToState(EditProfileEvent event) async* {
    if (event is ValidateForm) {
      validateForm(event.context);
    }

    if (event is UpdateUser) {
      state.currentUser = event.user;
      yield state;
    }

    if (event is CheckUsername) {
      // check if username matches criteria
      yield state.copyWith(status: Status.Loading);
      if (!usernameRegex.hasMatch(event.username) ||
          event.username.contains("@")) {
        yield state.copyWith(
            status: Status.Idle,
            usernameError: true,
            usernameMessage: "Username can only contain lowercase, _, numbers"
                "\nand length can be 3 to 10");
      } else {
        // check if username is his own
        if (state.currentUser.username == event.username) {
          print("username is not valid");
          yield state.copyWith(
              usernameError: false,
              usernameChecked: false,
              status: Status.Idle);
        } else {
          print("sending to server");
          // adding loading status
          yield state.copyWith(status: Status.Loading);
          final available = await APIService.api.checkUsername(event.username);
          if (available.isSuccessful) {
            // sending username available status
            yield state.copyWith(
              usernameChecked: true,
              usernameError: false,
              usernameMessage: "Username available",
              usernameAvailable: true,
              status: Status.Loaded,
            );
          } else {
            // sending username unavailable status
            yield state.copyWith(
                status: Status.Error,
                usernameError: false,
                usernameAvailable: false,
                usernameChecked: true,
                usernameMessage: "Username taken");
          }
        }
      }
    }
  }
}
