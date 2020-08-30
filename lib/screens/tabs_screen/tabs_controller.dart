import 'package:bloc/bloc.dart';
import 'package:focial/screens/chats/chats_screen.dart';
import 'package:focial/screens/explore/explore_screen.dart';
import 'package:focial/screens/home/home_screen.dart';
import 'package:focial/screens/notifications/notifications_screen.dart';
import 'package:focial/screens/profile/profile_screen.dart';

/*
-------------------------------------------------------------------------------
--------------------------------------Events-----------------------------------
-------------------------------------------------------------------------------
 */
abstract class TabsEvent {}

class ChangeScreen extends TabsEvent {
  int screen;

  ChangeScreen({this.screen});
}

class ChangeNoOfUpdates extends TabsEvent {
  int index, count;

  ChangeNoOfUpdates({this.index, this.count})
      : assert(index < 0 && index > 5),
        assert(count < 0);
}

/*
-------------------------------------------------------------------------------
--------------------------------------State------------------------------------
-------------------------------------------------------------------------------
 */
class TabsState {
  int currentScreenIndex;
  List<int> updates = List(5);

  TabsState({this.currentScreenIndex = 0, this.updates});

  TabsState copyWith({int currentScreenIndex, List<int> updates}) {
    return TabsState(
      currentScreenIndex: currentScreenIndex ?? this.currentScreenIndex,
      updates: updates ?? this.updates,
    );
  }
}

/*
-------------------------------------------------------------------------------
--------------------------------------Bloc-------------------------------------
-------------------------------------------------------------------------------
 */
class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc() : super(TabsState());

  final screens = [
    HomeScreen(),
    ExploreScreen(),
    NotificationsScreen(),
    ChatsScreen(),
    ProfileScreen()
  ];

  @override
  Stream<TabsState> mapEventToState(TabsEvent event) async* {
    if (event is ChangeScreen)
      yield state.copyWith(currentScreenIndex: event.screen);

    if (event is ChangeNoOfUpdates) {
      state.updates.removeAt(event.index);
      state.updates.insert(event.index, event.count);
      yield state.copyWith(updates: state.updates);
    }
  }
}
