import 'package:flutter/material.dart';
import 'package:focial/screens/tabs_screen/tabs_viewmodel.dart';
import 'package:focial/utils/theme.dart';
import 'package:focial/widgets/custom_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tabsScreenController = Provider.of<TabsViewmodel>(context);
    return Scaffold(
      body:
          tabsScreenController.screens[tabsScreenController.currentScreenIndex],
      bottomNavigationBar: CustomBottomNavBar(
        onTap: (int screen) {
          tabsScreenController.currentScreenIndex = screen;
        },
        iconSize: 22.0,
        currentSelection: tabsScreenController.currentScreenIndex,
        items: getBottomNavBarItems(),
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
