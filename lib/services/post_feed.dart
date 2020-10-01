import 'package:chopper/chopper.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/post_feed.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/status.dart';

class PostFeedService extends ChangeNotifier {
  List<PostFeed> _posts = [];
  ServiceStatus _status;

  Future<Response> getMyFeed() async {
    status = ServiceStatus.Loading;
    final response = await find<APIService>().api.getPosts();
    if (response.isSuccessful) {
      final parsedPosts = PostFeed.parseListFromJson(response.body["posts"]);
      _posts.addAll(parsedPosts);
      _posts = _posts.distinctBy((post) => post.id);
      status = ServiceStatus.Loaded;
      notifyListeners();
    } else {
      status = ServiceStatus.Error;
    }
    return response;
  }

  Future<Response> newPost(PostFeed post) async {
    status = ServiceStatus.Loading;
    final response = await find<APIService>().api.newPost(post.toJson());
    if (response.isSuccessful) {
      post.id = response.body["postId"];
      _posts.add(post);
      status = ServiceStatus.Loaded;
      notifyListeners();
    } else {
      status = ServiceStatus.Error;
    }
    return response;
  }

  List<PostFeed> get posts => _posts;

  set posts(List<PostFeed> value) {
    _posts = value;
    notifyListeners();
  }

  ServiceStatus get status => _status;

  set status(ServiceStatus value) {
    _status = value;
    notifyListeners();
  }
}
