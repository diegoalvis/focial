import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focial/screens/tabs_screen/tabs_controller.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/custom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final controller = TabsBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, TabsState>(
      cubit: controller,
      buildWhen: (prev, curr) =>
          prev.currentScreenIndex != curr.currentScreenIndex,
      builder: (context, state) => Scaffold(
        body: controller.screens[state.currentScreenIndex],
        bottomNavigationBar: CustomBottomNavBar(
          onTap: (int screen) {
            controller.add(ChangeScreen(screen: screen));
          },
          iconSize: 22.0,
          currentSelection: state.currentScreenIndex,
          items: getBottomNavBarItems(),
        ),
      ),
    );
  }

  List<CustomBottomNavBarItem> getBottomNavBarItems() => [
        CustomBottomNavBarItem(AppTheme.home, 0, "Home"),
        CustomBottomNavBarItem(FontAwesomeIcons.solidCompass, 0, "Explore"),
        CustomBottomNavBarItem(FontAwesomeIcons.solidBell, 0, "Notification"),
        CustomBottomNavBarItem(AppTheme.mail_alt, 0, "Messages"),
        CustomBottomNavBarItem(FontAwesomeIcons.userAlt, 0, "Profile"),
      ];
}
