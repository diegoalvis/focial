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
        radius: 23,
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
      this.borderRadius = 8.0,
      this.customChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textChild = Text(
      text?.toUpperCase() ?? "",
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

class AppPlatformButtonWithArrow extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;
  final EdgeInsets padding;

  const AppPlatformButtonWithArrow(
      {Key key, this.onPressed, this.text, this.color, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPlatformButton(
      color: color,
      onPressed: onPressed,
      customChild: SizedBox(
        height: 44.0,
        width: double.infinity,
        child: Row(
          children: [
            Spacer(),
            SizedBox(width: 16.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Material(
              type: MaterialType.circle,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).accentColor,
                  size: 18.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String asset, text;
  final VoidCallback onPressed;

  const SocialMediaButton({Key key, this.asset, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: AppPlatformButton(
        color: Colors.white,
        onPressed: onPressed,
        customChild: SizedBox(
          height: 44.0,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(asset),
                SizedBox(width: 24.0),
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonWithIconArrow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const ButtonWithIconArrow(
      {Key key, this.icon, this.text, this.onPressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4.0),
        child: Row(
          children: [
            SizedBox(width: 4.0),
            Material(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Text(
              text,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}

class StatisticsText extends StatelessWidget {
  final String count, text;
  final VoidCallback onPressed;

  const StatisticsText({Key key, this.count, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: count + "\n",
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Colors.black),
          ),
          TextSpan(
            text: text,
            style: TextStyle(color: Colors.black),
          )
        ]),
      ),
    );
  }
}
