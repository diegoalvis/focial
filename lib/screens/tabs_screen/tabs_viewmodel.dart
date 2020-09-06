import 'package:flutter/cupertino.dart';
import 'package:focial/screens/chats/chats_screen.dart';
import 'package:focial/screens/explore/explore_screen.dart';
import 'package:focial/screens/home/home_screen.dart';
import 'package:focial/screens/notifications/notifications_screen.dart';
import 'package:focial/screens/profile/profile_screen.dart';

class TabsViewmodel extends ChangeNotifier {
  int _currentScreenIndex = 0;
  List<int> _updates = List(5);

  final screens = [
    HomeScreen(),
    ExploreScreen(),
    NotificationsScreen(),
    ChatsScreen(),
    ProfileScreen()
  ];

  int get currentScreenIndex => _currentScreenIndex;

  set currentScreenIndex(int value) {
    _currentScreenIndex = value;
    notifyListeners();
  }

  List<int> get updates => _updates;

  set updates(List<int> value) {
    _updates = value;
    notifyListeners();
  }

  updateNotificationCount(int index, int count) {
    _updates.removeAt(index);
    _updates.insert(index, count);
    notifyListeners();
  }
}
