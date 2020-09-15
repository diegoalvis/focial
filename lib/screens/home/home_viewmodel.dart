import 'package:flutter/cupertino.dart';
import 'package:focial/models/user.dart';
import 'package:focial/screens/posts/new_post.dart';
import 'package:focial/services/finder.dart';
import 'package:focial/services/user.dart';
import 'package:focial/utils/navigation.dart';

class HomeViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  User get currentUser => find<UserData>().currentUser;

  void newPost() {
    Navigator.of(_context).push(AppNavigation.route(NewPost()));
  }
}
