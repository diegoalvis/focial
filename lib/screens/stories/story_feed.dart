import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:focial/api/urls.dart';
import 'package:focial/models/user.dart';
import 'package:focial/screens/stories/new_story.dart';
import 'package:focial/screens/stories/view_story.dart';
import 'package:focial/services/story.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/navigation.dart';
import 'package:focial/utils/theme.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';

class FocialStories extends StatelessWidget {
  User get currentUser => GetIt.I<UserData>().currentUser;

  void handleCurrentUserStory(BuildContext context, StoryService provider) {
    if (provider.storyFeed[currentUser.id] != null) {
      if (provider.storyFeed[currentUser.id].stories.length > 0) {
        print("show him his stories");
        Navigator.of(context).push(AppNavigation.route(ViewStoriesScreen(
            story: provider.storyFeed[currentUser.id].stories.toList()[0])));
      }
    } else {
      print("create new story");
      Navigator.of(context).push(AppNavigation.route(NewStory()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoryService>.reactive(
      viewModelBuilder: () => GetIt.I<StoryService>(),
      disposeViewModel: false,
      onModelReady: (m) => {},
      builder: (context, provider, child) {
        var stories = [
          GestureDetector(
            child: ViewStoryButton(
              loading: false,
              currentUser: true,
              avatar: currentUser.photoUrl,
            ),
            onTap: () => handleCurrentUserStory(context, provider),
          ),
        ];
        return SizedBox(
          height: storySize,
          width: double.infinity,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: stories,
          ),
        );
      },
    );
  }
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
              backgroundImage: CachedNetworkImageProvider(avatar == null
                  ? "https://avatars3.githubusercontent.com/u/35001172?s=460&u=ed19790a0421a2e296d2e1faac50e40468669896&v=4"
                  : avatar.contains("http")
                      ? avatar
                      : Urls.assetsBase + avatar),
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
