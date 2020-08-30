import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/api/urls.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/loader.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(
      MaterialApp(
        home: ProfileScreen(),
      ),
    );

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var pp;

  final userData = GetIt.I<UserData>();

  void _updateProfilePicture() async {
    // update profile picture
    pp = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pp != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: pp.path,
        // aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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

  var cp;

  void _updateCoverPicture() async {
    // update profile picture
    cp = await ImagePicker.platform
        .pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (cp != null) {
      File croppedFile = await ImageCropper.cropImage(
        sourcePath: cp.path,
        // aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // return PlatformScaffold(
    //   body: profile(
    //       UserDataState(
    //         currentUser: User(
    //           firstName: 'Random',
    //           lastName: 'Girl',
    //           photoUrl: 'a',
    //         ),
    //       ),
    //       size),
    // );

    return PlatformScaffold(
      backgroundColor: Colors.white.withOpacity(0.1),
      body: BlocBuilder<UserData, UserDataState>(
        cubit: userData..fetchUser(),
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          switch (state.status) {
            case Status.Idle:
              return loading();
            case Status.Loading:
              return loading();
            case Status.Loaded:
              return profile(state, size);
            case Status.Error:
              return error();
          }
          return loading();
        },
      ),
    );
  }

  Widget loading() => Center(
        child: Loader(
          size: 128,
        ),
      );

  Widget idle() => Center(child: Text('Idle'));

  Widget error() => Center(child: Text('Cannot load user data'));

  final padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);

  Widget profile(UserDataState state, Size size) => ListView(
        children: [
          _getProfileAndCoverPic(state, size),
          Center(
            child: Text(
              '${state.currentUser.firstName} ${state.currentUser.lastName}',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "${state.currentUser.bio ?? " "}",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          _getProfileStats(state),
          SizedBox(height: 8.0),
          _getSettingsSection(state),
        ],
      );

  Widget _getProfileAndCoverPic(UserDataState state, Size size) => SizedBox(
        height: 320.0,
        child: Stack(
          children: [
            state.currentUser.coverPic != null &&
                    state.currentUser.coverPic.length > 5
                ? CachedNetworkImage(
                    imageUrl: Urls.assetsBase + state.currentUser.coverPic,
                    fit: BoxFit.fill,
                    height: 260.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    placeholder: (context, data) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageBuilder: (context, image) => Material(
                      elevation: 4.0,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(150.0, 20),
                          bottomRight: Radius.elliptical(150.0, 20)),
                      child: Image(
                        image: image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Image.asset(
                    "assets/pictures/girl-cover.jpg",
                    height: 260.0,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    frameBuilder: (context, child, res, re) => Material(
                      elevation: 4.0,
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(150.0, 20),
                          bottomRight: Radius.elliptical(150.0, 20)),
                      child: child,
                    ),
                  ),
            Positioned(
              top: 160.0,
              left: (size.width - 150) / 2,
              height: 140.0,
              width: 140.0,
              child: InkWell(
                onTap: () {
                  print("profile picture");
                },
                child: state.currentUser.photoUrl != null &&
                        state.currentUser.photoUrl.length > 5
                    ? CachedNetworkImage(
                        imageUrl: Urls.assetsBase + state.currentUser.photoUrl,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        placeholder: (context, data) => Center(
                          child: CircularProgressIndicator(),
                        ),
                        imageBuilder: (context, image) => _frameProfilePicture(
                            context, Image(image: image), 100.0, true),
                      )
                    : Image.asset(
                        "assets/user.jpg",
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        frameBuilder: _frameProfilePicture,
                      ),
              ),
            ),
            Positioned(
              top: 275.0,
              right: (size.width - 165) / 2,
              child: InkWell(
                onTap: () {
                  _updateProfilePicture();
                  // print("change");
                },
                child: CameraButton(),
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: InkWell(
                onTap: () {
                  _updateCoverPicture();
                },
                child: CameraButton(),
              ),
            )
          ],
        ),
      );

  Widget _getProfileStats(UserDataState state) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatisticsText(
              count: "${state.currentUser.posts ?? 0}",
              text: "Posts",
            ),
            StatisticsText(
              count: "${state.currentUser.followers ?? 0}",
              text: "Followers",
            ),
            StatisticsText(
              count: "${state.currentUser.following ?? 0}",
              text: "Following",
            ),
          ],
        ),
      );

  Widget _getSettingsSection(UserDataState state) => Card(
        elevation: 0.5,
        margin: const EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonWithIconArrow(
                onPressed: () {},
                icon: FontAwesomeIcons.userAlt,
                text: 'Edit Profile',
                color: Colors.indigoAccent,
              ),
              ButtonWithIconArrow(
                icon: FontAwesomeIcons.userFriends,
                text: 'Invite Friends',
                color: Colors.lightBlueAccent,
              ),
              ButtonWithIconArrow(
                icon: FontAwesomeIcons.solidBell,
                text: 'Notification Settings',
                color: Colors.pinkAccent,
              ),
              ButtonWithIconArrow(
                icon: FontAwesomeIcons.photoVideo,
                text: 'Photos & media',
                color: Colors.deepOrangeAccent,
              ),
              ButtonWithIconArrow(
                icon: Icons.settings,
                text: 'Account Settings',
                color: Colors.greenAccent,
              ),
              ButtonWithIconArrow(
                icon: FontAwesomeIcons.download,
                text: 'App Updates',
                color: Colors.indigoAccent,
              ),
              ButtonWithIconArrow(
                icon: FontAwesomeIcons.powerOff,
                text: 'Log out',
                color: Colors.redAccent,
              ),
              SizedBox(height: 32.0),
              StackInFlow(),
            ],
          ),
        ),
      );

  Widget _frameProfilePicture(context, child, res, rr) => Material(
        color: Colors.white,
        child: child,
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8.0),
      );
}

class CameraButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.circle,
      color: Colors.grey.withOpacity(0.75),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(
          FontAwesomeIcons.camera,
          color: Colors.white,
          size: 16.0,
        ),
      ),
    );
  }
}

final random = new Random();
