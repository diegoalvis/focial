import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/user.dart';
import 'package:focial/services/api.dart';
import 'package:focial/utils/overlays.dart';
import 'package:ots/ots.dart';

enum Status { Idle, Loading, Loaded, Error }

class UserDataState {
  User currentUser = User();
  Status status;

  UserDataState({this.currentUser, this.status = Status.Idle});
}

class UserData extends Cubit<UserDataState> {
  UserData() : super(UserDataState(currentUser: User()));

  Future<void> fetchUser() async {
    if (state.status == Status.Loading || state.status == Status.Loaded) return;
    final response = await APIService.api.getUser();
    emit(UserDataState(status: Status.Loading));
    if (response.isSuccessful) {
      emit(
        UserDataState(
          currentUser: User.fromJson(response.body["user"]),
          status: Status.Loaded,
        ),
      );
    } else {
      debugPrint("User data can't be loaded ${response.error}");
      emit(UserDataState(status: Status.Error));
    }
  }

  Future<Response> updateUserProfile(User user) async {
    emit(UserDataState(currentUser: user, status: Status.Loading));
    final response = await APIService.api.updateUser(user.toJson());
    if (response.isSuccessful) {
      emit(UserDataState(currentUser: user, status: Status.Loaded));
    }
    return response;
  }

  Future<void> updateProfilePicture(String filePath) async {
    showLoader(isModal: true);
    final response = await APIService.api.uploadProfilePicture(filePath);
    emit(UserDataState(status: Status.Loading, currentUser: state.currentUser));
    if (response.isSuccessful) {
      _updatePhotoUrl(response.body["photoUrl"]);
      AppOverlays.showSuccess("Server response", "Profile picture uploaded");
    } else {
      AppOverlays.showError(
          "Server response", 'Unable to update user picture, please try later');
      emit(
          UserDataState(status: Status.Loaded, currentUser: state.currentUser));
    }
    hideLoader();
  }

  Future<void> updateCoverPicture(String filePath) async {
    showLoader(isModal: true);
    final response = await APIService.api.uploadCoverPicture(filePath);
    emit(UserDataState(status: Status.Loading, currentUser: state.currentUser));
    if (response.isSuccessful) {
      _updateCoverPic(response.body["photoUrl"]);
      AppOverlays.showSuccess("Server response", "Cover picture uploaded");
    } else {
      AppOverlays.showError(
          "Server response", 'Unable to update user picture, please try later');
      emit(
          UserDataState(status: Status.Loaded, currentUser: state.currentUser));
    }
    hideLoader();
  }

  void _updatePhotoUrl(String photoUrl) {
    state.currentUser.photoUrl = photoUrl;
    emit(UserDataState(
      status: Status.Loaded,
      currentUser: state.currentUser,
    ));
  }

  void _updateCoverPic(String photoUrl) {
    state.currentUser.coverPic = photoUrl;
    emit(UserDataState(
      status: Status.Loaded,
      currentUser: state.currentUser,
    ));
  }
}
