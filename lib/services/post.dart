import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:focial/models/post.dart';
import 'package:focial/services/api.dart';
import 'package:focial/services/finder.dart';

class FocialPostService extends ChangeNotifier {
  List<FocialPost> _posts = [];

  Future<Response> newPost(FocialPost post) async {
    final response = await find<APIService>().api.newPost(post.toJson());
    if (response.isSuccessful) {
      post.id = response.body["postId"];
      _posts.add(post);
      notifyListeners();
    }
    return response;
  }

  List<FocialPost> get posts => _posts;

  set posts(List<FocialPost> value) {
    _posts = value;
    notifyListeners();
  }
}
