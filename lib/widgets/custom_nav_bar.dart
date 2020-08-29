import 'package:flutter/material.dart';
import 'package:focial/utils/theme.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<CustomBottomNavBarItem> items;
  final double height;
  final int currentSelection;
  final Function(int) onTap;
  final Color selectedColor, unselectedColor;
  final double iconSize;

  const CustomBottomNavBar(
      {Key key,
      this.items,
      this.height = 50.0,
      this.currentSelection = 0,
      this.onTap,
      this.selectedColor = AppTheme.primaryColor,
      this.unselectedColor = Colors.grey,
      this.iconSize = 24.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 8.0,
      child: SizedBox(
        height: height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            items.length,
            (index) => InkWell(
              borderRadius: BorderRadius.circular(24.0),
              onTap: () => onTap(index),
              child: CustomBottomNavBarItemBuilder(
                icon: items[index].icon,
                notificationCount: items[index].notificationsCount,
                size: iconSize,
                color:
                    index == currentSelection ? selectedColor : unselectedColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavBarItem {
  final IconData icon;
  final int notificationsCount;
  final String title;

  CustomBottomNavBarItem(this.icon, this.notificationsCount, this.title);
}

class CustomBottomNavBarItemBuilder extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color color;
  final String text;
  final TextStyle style;
  final int notificationCount;

  const CustomBottomNavBarItemBuilder(
      {Key key,
      this.icon,
      this.size,
      this.color,
      this.text,
      this.style,
      this.notificationCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: Center(
        child: Stack(
          children: [
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Icon(
                icon,
                size: size,
                color: color,
              ),
            ),
            Positioned(
              top: 4.0,
              right: 4.0,
              child: notificationCount > 0
                  ? Material(
                      type: MaterialType.circle,
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '$notificationCount',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 8.0,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
      // child: Stack(
      //   overflow: Overflow.clip,
      //   children: [
      //     Positioned(
      //       top: 0.0,
      //       height: size,
      //       width: size,
      //       child: ,
      //     ),
      //     // Positioned(
      //     //   top: size + 4.0,
      //     //   child: Text(
      //     //     text,
      //     //     style: style,
      //     //   ),
      //     // ),
      //     Positioned(
      //       top: -5.0,
      //       right: 0.0,
      //       child: notificationCount > 0
      //           ? Material(
      //               type: MaterialType.circle,
      //               color: Colors.red,
      //               child: Padding(
      //                 padding: const EdgeInsets.all(4.0),
      //                 child: Text(
      //                   '$notificationCount',
      //                   style: TextStyle(color: Colors.white),
      //                 ),
      //               ),
      //             )
      //           : SizedBox(),
      //     )
      //   ],
      // ),
    );
  }
}
