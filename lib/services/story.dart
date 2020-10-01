import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/author_data.dart';
import 'package:focial/models/story.dart';
import 'package:focial/models/story_feed.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';

class StoryService extends ChangeNotifier {
  // userId, StoryFeed(userData, stories)
  Map<String, StoryFeed> _storyFeed = Map();
  Status _status = Status.Idle;

  Future<void> getStatuses() async {
    final response = await find<APIService>().api.getStoryFeed();
    if (response.isSuccessful) {
      final storyFeed = response.body["storyFeed"];
      _storyFeed.addAll(StoryFeed.parseFromJSONAsList(storyFeed));
      notifyListeners();
      print("no of stories by person: ${storyFeed.length}");
    }
  }

  Future<Response> newStory(Story story) async {
    final currentUser = find<UserData>().currentUser;
    final response = await find<APIService>().api.newStory(story.toJson());

    story.views = [];
    if (response.isSuccessful) {
      story.storyId = response.body["storyId"];

      // this is users' first story
      if (!_storyFeed.containsKey(currentUser.id)) {
        _storyFeed[currentUser.id] = StoryFeed(
          authorData: AuthorData(
            photoUrl: currentUser.photoUrl,
            username: currentUser.username,
          ),
          stories: [story],
        );
      } else {
        _storyFeed.update(currentUser.id, (value) {
          if (value.stories == null) value.stories = [];
          value.stories.add(story);
          return value;
        });
      }
    }
    return response;
  }

  Map<String, StoryFeed> get storyFeed => _storyFeed;

  set storyFeed(Map<String, StoryFeed> value) {
    _storyFeed = value;
    notifyListeners();
  }

  Status get status => _status;

  set status(Status value) {
    _status = value;
    notifyListeners();
  }
}
