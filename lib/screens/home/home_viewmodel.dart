import 'package:flutter/cupertino.dart';
import 'package:focial/models/user.dart';
import 'package:focial/services/user.dart';
import 'package:get_it/get_it.dart';

class HomeViewModel extends ChangeNotifier {
  BuildContext _context;

  void init(BuildContext context) {
    _context = context;
  }

  User get currentUser => GetIt.I<UserData>().currentUser;
}
