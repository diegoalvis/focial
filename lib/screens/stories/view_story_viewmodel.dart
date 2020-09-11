import 'package:flutter/cupertino.dart';

class ViewStoryViewmodel extends ChangeNotifier {
  double _barValue = 0.0;

  void init(BuildContext context) {
    // Future.delayed(Duration(milliseconds: 5200)).then((value) => _pop(context));
    // incValue();
  }

  void _pop(BuildContext context) {
    Navigator.of(context).pop();
  }

  double get barValue => _barValue;

  set barValue(double value) {
    _barValue = value;
    notifyListeners();
  }
}
