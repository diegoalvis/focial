import 'package:focial/services/finder.dart';
import 'package:focial/services/post_feed.dart';
import 'package:focial/services/story.dart';
import 'package:focial/services/user.dart';

class AppDataService {
  void onLogin() {
    find<UserData>()..fetchUser();
    find<StoryService>()..getStatuses();
    find<PostFeedService>()..getMyFeed();
  }

  void onLogOut() {}

  void onAppOpen() {
    onLogin();
  }

  void onAppReOpen() {}

  void onAppClosed() {}
}
