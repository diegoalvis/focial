import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/*
-------------------------------------------------------------------------------
--------------------------------------Events-----------------------------------
-------------------------------------------------------------------------------
 */
abstract class ProfileEvent {}

class UpdateProfilePicture extends ProfileEvent {}

class UpdateCoverPicture extends ProfileEvent {}

/*
-------------------------------------------------------------------------------
--------------------------------------State------------------------------------
-------------------------------------------------------------------------------
 */
class ProfileState {}

/*
-------------------------------------------------------------------------------
--------------------------------------Bloc-------------------------------------
-------------------------------------------------------------------------------
 */
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  var pp;
  var cp;
  final userData = GetIt.I<UserData>()..fetchUser();

  ProfileBloc() : super(ProfileState());

  void _pickProfilePicture() async {
    // ignore: invalid_use_of_visible_for_testing_member
    pp = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pp != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: pp.path,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        userData.updateProfilePicture(croppedFile.path);
      }
    }
  }

  void _pickCoverPicture() async {
    // ignore: invalid_use_of_visible_for_testing_member
    cp = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (cp != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: cp.path,
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: AppTheme.primaryColor,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      );
      if (croppedFile != null) {
        userData.updateCoverPicture(croppedFile.path);
      }
    }
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is UpdateProfilePicture) _pickProfilePicture();
    if (event is UpdateCoverPicture) _pickCoverPicture();
    yield state;
  }
}
