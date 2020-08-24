import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const SocialButton({Key key, this.asset, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: onPressed,
      child: CircleAvatar(
        radius: 26,
//        foregroundColor: Colors.white,
        backgroundColor: Colors.white,
        backgroundImage: AssetImage(asset),
      ),
    );
  }
}

class AppPlatformButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final double elevation;
  final TextStyle style;
  final EdgeInsets padding;
  final double height, width, borderRadius;
  final Widget customChild;

  const AppPlatformButton(
      {Key key,
      this.onPressed,
      this.text,
      this.color,
      this.elevation = 4.0,
      this.style,
      this.padding,
      this.height,
      this.width,
      this.borderRadius = 16.0,
      this.customChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textChild = Text(
      text?.toUpperCase(),
      style: style ??
          TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
    );

    final child = customChild != null
        ? customChild
        : (height != null && width != null
            ? SizedBox(
                height: height,
                width: width,
                child: Center(child: textChild),
              )
            : textChild);

    return Platform.isIOS
        ? CupertinoButton(
            padding: padding,
            borderRadius: BorderRadius.circular(borderRadius),
            color: color ?? Theme.of(context).primaryColor,
            child: child,
            onPressed: onPressed,
          )
        : RaisedButton(
            padding: padding,
            elevation: elevation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            color: color ?? Theme.of(context).primaryColor,
            child: child,
            onPressed: onPressed,
          );
  }
}
