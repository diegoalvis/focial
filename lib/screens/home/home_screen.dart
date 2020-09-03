import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:focial/utils/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  Widget _newPostAndSearchButton() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        child: Row(
          children: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.camera,
                color: Colors.grey,
                size: 20.0,
              ),
              onPressed: () {},
            ),
            Spacer(),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.search,
                color: Colors.grey,
                size: 20.0,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );

  Widget _body() => ListView(
        children: [
          // New post & search button
          _newPostAndSearchButton(),
          // stories
          SizedBox(height: 8.0),
          SizedBox(
            height: storySize,
            width: double.infinity,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  child: ViewStoryButton(
                    loading: false,
                    currentUser: true,
                  ),
                  onTap: () {},
                ),
                ViewStoryButton(
                  seen: true,
                ),
                ViewStoryButton(),
                ViewStoryButton(),
                ViewStoryButton(),
                ViewStoryButton(),
                ViewStoryButton(),
              ],
            ),
          )
          // feed
        ],
      );
}

final storySize = 60.0;
final avatarPadding = 6.0;
final whiteBackgroundPadding = 4.0;
final stroke = 3.0;

class ViewStoryButton extends StatelessWidget {
  final bool loading, seen, currentUser;
  final avatarPadding = 5.0;
  final whiteBackgroundPadding = 3.0;
  final String avatar;

  const ViewStoryButton(
      {Key key,
      this.loading = false,
      this.seen = false,
      this.currentUser = false,
      this.avatar =
          "https://avatars3.githubusercontent.com/u/35001172?s=460&u=ed19790a0421a2e296d2e1faac50e40468669896&v=4"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Stack(
        children: [
          loading
              ? SizedBox(
                  height: storySize,
                  width: storySize,
                  child: Padding(
                    padding: const EdgeInsets.all(1.7),
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.orange),
                      strokeWidth: stroke,
                    ),
                  ),
                )
              : Material(
                  type: MaterialType.circle,
                  color: seen ? Colors.black12 : AppTheme.orange,
                  child: SizedBox(
                    height: storySize,
                    width: storySize,
                  ),
                ),
          Positioned(
            top: whiteBackgroundPadding,
            bottom: whiteBackgroundPadding,
            right: whiteBackgroundPadding,
            left: whiteBackgroundPadding,
            child: Material(
              type: MaterialType.circle,
              color: Colors.white,
              child: SizedBox(
                height: storySize,
                width: storySize,
              ),
            ),
          ),
          Positioned(
            top: avatarPadding,
            bottom: avatarPadding,
            right: avatarPadding,
            left: avatarPadding,
            child: CircleAvatar(
              radius: storySize,
              backgroundColor: Colors.white10,
              backgroundImage: CachedNetworkImageProvider(avatar),
            ),
          ),
          currentUser
              ? Positioned(
                  bottom: 0.0,
                  right: 0.0,
                  child: Material(
                    type: MaterialType.circle,
                    color: AppTheme.primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 16.0,
                      ),
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
