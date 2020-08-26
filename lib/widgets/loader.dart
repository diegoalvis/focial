import 'package:flutter/material.dart';
import 'package:focial/utils/assets.dart';

class Loader extends StatelessWidget {
  final double size;

  const Loader({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Image.asset(Assets.LOADER),
    );
  }
}
