import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/api/urls.dart';
import 'package:focial/screens/profile/edit_profile_screen.dart';
import 'package:focial/screens/profile/profile_viewmodel.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/button.dart';
import 'package:focial/widgets/loader.dart';
import 'package:focial/widgets/services/user_data.dart';
import 'package:focial/widgets/stackinflow.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PlatformScaffold(
      backgroundColor: Colors.white.withOpacity(0.1),
      body: ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onModelReady: (m) => m.init(context),
        disposeViewModel: false,
        builder: (context, model, child) {
          return _profileModel(model, size, context);
        },
      ),
    );
  }

  // todo: to be optimized
  Widget _profileModel(
      ProfileViewModel profileViewModel, Size size, BuildContext context) {
    return UserDataWidget(
      builder: (context, userData, child) =>
          _body(userData, size, context, profileViewModel),
    );
  }

  Widget _body(UserData userDataProvider, Size size, BuildContext context,
      ProfileViewModel profileViewModel) {
    switch (userDataProvider.status) {
      case Status.Idle:
        return loading();
      case Status.Loading:
        return loading();
      case Status.Loaded:
        return profile(userDataProvider, size, context, profileViewModel);
      case Status.Error:
        return error();
    }
    return loading();
  }

  Widget loading() => Center(
        child: Loader(
          size: 128,
        ),
      );

  Widget idle() => Center(child: Text('Idle'));

  Widget error() => Center(child: Text('Cannot load user data'));

  final padding = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);

  Widget profile(UserData userDataProvider, Size size, BuildContext context,
          ProfileViewModel profileViewModel) =>
      ListView(
        children: [
          _getProfileAndCoverPic(userDataProvider, size, profileViewModel),
          Center(
            child: Text(
              '${userDataProvider.currentUser.firstName} ${userDataProvider.currentUser.lastName}',
              style: TextStyle(
                color: AppTheme.textColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            "${userDataProvider.currentUser.bio ?? " "}",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          _getProfileStats(userDataProvider),
          SizedBox(height: 8.0),
          _getSettingsSection(userDataProvider, context),
        ],
      );

  Widget _getProfileAndCoverPic(UserData userDataProvider, Size size,
          ProfileViewModel profileViewModel) =>
      SizedBox(
        height: 320.0,
        child: Stack(
          children: [
            userDataProvider.currentUser.coverPic != null &&
                    userDataProvider.currentUser.coverPic.length > 5
                ? CachedNetworkImage(
                    imageUrl:
                        Urls.assetsBase + userDataProvider.currentUser.coverPic,
                    fit: BoxFit.fill,
                    height: 260.0,
                    width: double.infinity,
                    alignment: Alignment.center,
                    placeholder: (context, data) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    imageBuilder: (context, image) => _buildCoverFrame(
                      Image(
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
                    frameBuilder: (context, child, res, re) =>
                        _buildCoverFrame(child),
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
                child: userDataProvider.currentUser.photoUrl != null &&
                        userDataProvider.currentUser.photoUrl.length > 5
                    ? CachedNetworkImage(
                        imageUrl: Urls.assetsBase +
                            userDataProvider.currentUser.photoUrl,
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
                onTap: () => profileViewModel.pickProfilePicture(),
                child: CameraButton(),
              ),
            ),
            Positioned(
              top: 10.0,
              right: 10.0,
              child: InkWell(
                onTap: () => profileViewModel.pickCoverPicture(),
                child: CameraButton(),
              ),
            )
          ],
        ),
      );

  Widget _getProfileStats(UserData userDataProvider) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            StatisticsText(
              count: "${userDataProvider.currentUser.posts ?? 0}",
              text: "Posts",
            ),
            StatisticsText(
              count: "${userDataProvider.currentUser.followers ?? 0}",
              text: "Followers",
            ),
            StatisticsText(
              count: "${userDataProvider.currentUser.following ?? 0}",
              text: "Following",
            ),
          ],
        ),
      );

  Widget _getSettingsSection(UserData userDataProvider, BuildContext context) =>
      Card(
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
                onPressed: () => pushScreen(
                    EditProfileScreen(
                        // user: userDataProvider.currentUser
                    ),
                    context),
                icon: FontAwesomeIcons.userAlt,
                text: 'Edit Profile',
                color: Colors.indigoAccent,
              ),
              ButtonWithIconArrow(
                onPressed: () {
                  Share.share(
                      'Check out Focial a trending social media app https://play.google.com/store/apps/details?id=org.stackinflow.focial&hl=en_IN');
                },
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

  Widget _buildCoverFrame(Widget child) => Material(
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(150.0, 20),
            bottomRight: Radius.elliptical(150.0, 20)),
        child: child,
      );

  void pushScreen(Widget to, BuildContext context) =>
      Navigator.of(context).push(AppNavigation.route(to));
}
