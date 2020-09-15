import 'package:focial/services/finder.dart';
import 'package:focial/services/story.dart';
import 'package:focial/services/user.dart';

class AppDataService {
  void onLogin() {
    find<UserData>()..fetchUser();
  }

  void onLogOut() {}

  void onAppOpen() {
    find<UserData>()..fetchUser();
    find<StoryService>()..getStatuses();
  }

  void onAppReOpen() {}

  void onAppClosed() {}
}
